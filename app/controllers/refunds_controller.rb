class RefundsController < ApplicationController
  # before_action :set_order, only: [:checkout, :pay, :archive]
  # skip_before_action :verify_authenticity_token, only: [:paid]

  layout 'app'

  def index
    authorize Refund

    respond_to do |format|
      format.html
      format.json do
        @orders = Order.where(user: Current.user, state: [:active, :paid, :archived])
        render json: { orders: @orders }
        # @orders = Order
        #   .includes(
        #     :user,
        #     order_items: [
        #       :size,
        #       {
        #         variant: [
        #           { product: [:category, :variants] },
        #           :color,
        #           :availabilities,
        #           :sizes,
        #           :images
        #         ]
        #       }
        #     ]
        #   ).where(user: Current.user).where.not(state: [:undef]).order(created_at: :desc)
      end
    end
  end

  def create
    authorize Order

    @order = Order.new(user: Current.user)
    @order.assign_attributes(order_params)

    Current.user.carts.each do |cart|
      @order.order_items.build(variant: cart.variant, quantity: cart.quantity, size: cart.size)
    end

    if @order.save
      @order.activate!
      Current.user.carts.destroy_all
      head :ok, location: pay_order_path(@order)
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def pay
    authorize @order

    unless @order.purchasable?
      redirect_to orders_user_path(current_user, :order => @order.id), notice: 'Неверный заказ' and return
    end

    render layout: false
  end

  def archive
    authorize @order
    @order.archive!
    head :ok
  end

  def paid
    authorize Order

    if Digest::MD5.hexdigest(params.slice(:id, :sum, :clientid, :orderid).values.push(Rails.application.credentials[Rails.env.to_sym][:payment][:key]).join('')) == params[:key]
      order = Order.find(params[:orderid])

      if order.active?
        order.update(payment_id: params[:id], payment_amount: params[:sum])
        order.pay!
      end

      if order.paid?
        render inline: ('OK ' + Digest::MD5.hexdigest(params[:id] + Rails.application.credentials[Rails.env.to_sym][:payment][:key]))
      else
        head :ok
      end
    else
      head :unprocessable_entity
    end
  end

  private
  def order_params
    params.require(:order).permit(
      :address,
      user_attributes: [
        :name, :s_name, :phone, :email
      ]
    )
  end

  def set_order
    @order = Order.find(params[:id])
  end

end
