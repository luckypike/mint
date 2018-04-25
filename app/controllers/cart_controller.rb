class CartController < ApplicationController
  include ProductsHelper
  include ActionView::Helpers::NumberHelper

  before_action :set_user, only: [:show]
  before_action :set_sizes, only: [:show]

  def show
    authorize :cart

    @items = Cart.where(user: current_user)
    @order = Order.where(state: :undef, user: current_user).first_or_create!
    @user = current_user
    @sum = @items.map{ |i| (i.variant.product.discount_price(@user.get_discount)) * i.quantity }.sum
  end

  def discount
    authorize :cart

    if params[:phone].present?
      phone = params[:phone].gsub('+7', '8').gsub(/\D/, '')
      discount = Discount.find_by phone: phone

      discount.present? ? current_user.discount = discount : current_user.discount = nil


      @user = current_user
      @items = Cart.where(user: current_user)
      @sum = @items.map{ |i| (i.variant.product.discount_price(@user.get_discount)) * i.quantity }.sum
      render json: {total: "Товаров на сумму: #{number_to_rub(@sum)}"}
    else
      render layout: false
    end

  end

  def destroy
    authorize :cart
    cart = Cart.where(id: params[:id], user: current_user)
    if cart
      cart.destroy_all
    end
    head :ok
  end
end
