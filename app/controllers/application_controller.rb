class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :not_authenticated

  protect_from_forgery with: :exception

  before_action :set_cats
  before_action :set_current
  before_action :set_cart
  before_action :set_wishlist

  after_action :verify_authorized, unless: :devise_controller?

  private
  def set_current
    Current.user = current_user
  end

  def set_cats
    @themes = Theme.active.order(weight: :asc)
    @categories = Category.active.where.not(variants_counter: 0).order(weight: :asc)
    @colors = Color.includes(:parent_color).order(title: :asc)
  end

  def set_cart
    @cart = Cart.where(user: current_user)
  end

  def set_wishlist
    @wishlist = Wishlist.where(user: current_user)
  end

  def not_authenticated
    session[:return_to_url] = request.original_fullpath
    redirect_to login_path, alert: t(:login_first)
  end

  def set_user
    unless user_signed_in?
      user = User.create(email: "guest_#{Devise.friendly_token.first(10)}@mint-store.ru")
      user.save!(validate: false)
      sign_in(user)
    end
  end

  def set_sizes
    @sizes = Size.all.map{|s| [s.id, s.size]}.to_h
  end
end
