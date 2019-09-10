class Variant < ApplicationRecord
  default_scope { includes(:images, { product: :category }).order(pinned: :desc, created_at: :desc) }

  # scope :available, -> { where(state: %i[active soon]) }
  # scope :visible, -> { Current.user&.is_editor? && where(show: true) }

  enum state: { unpub: 0, active: 1, archived: 2 }

  belongs_to :product, inverse_of: :variants
  accepts_nested_attributes_for :product

  has_one :category, through: :product

  belongs_to :color

  has_many :images, as: :imagable, dependent: :destroy
  accepts_nested_attributes_for :images

  has_many :availabilities, dependent: :destroy
  has_many :sizes, through: :availabilities

  validates :color, uniqueness: { scope: :product_id }
  validates :code, uniqueness: true, unless: -> { code.blank? }
  # validates :price, presence: true, if: -> { active? }

  before_save :default_values

  after_save :cache_sizes
  # after_save :check_state
  after_save :check_category

  translates :desc, :comp
  globalize_accessors locales: I18n.available_locales, attributes: %i[desc comp]

  # --------------

  accepts_nested_attributes_for :availabilities, allow_destroy: true

  has_many :wishlists, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :order_items, dependent: :destroy

  has_many :kitables, dependent: :destroy
  has_many :kits, through: :kitables
  has_many :notifications, dependent: :destroy

  include ActionView::Helpers::NumberHelper
  include ProductsHelper

  def available?
    availabilities.active.any? && price_sell.present?
  end

  def price_sell
    price_last.presence || price
  end

  def discount_price(discount)
    price_sell - price_sell * discount
  end

  def entity_created_at
    product.created_at
  end

  def photo
    images[0].photo.presence || nil
  end

  def title
    product.title_safe
  end

  def in_wishlist(user)
    wishlists.where(user: user).any?
  end

  def in_notification(user)
    notifications.where(user: user).any?
  end

  def in_order?
    OrderItem.where(variant_id: self).any?
  end

  # TODO: переписать этот метод чтобы для более няшного кода
  def decrease item
    availability = availabilities.where(store_id: 1, size_id: item.size_id).where('quantity > ?', 0).first
    availability = availabilities.where.not(store_id: 1).where(size_id: item.size_id).where('quantity > ?', 0).first unless availability

    if availability
      if item.quantity > availability.quantity
        diff = item.quantity - availability.quantity
        availability.quantity = 0
        availability.save
        availability = availabilities.where.not(store_id: 1).where(size_id: item.size_id).where('quantity > ?', 0).first
        availability.quantity -= diff
        availability.save
      else
        availability.quantity -= item.quantity
        availability.save
      end
    else
      # TODO: добавить действие если произошел казус что оба заказа оплачивали одновременно
    end
  end

  # def check_state
  #   if soon && availabilities.all? { |a| !a.active? }
  #     update_column(:state, :soon)
  #   elsif !soon && availabilities.all? { |a| !a.active? }
  #     update_column(:state, :archived)
  #   else
  #     update_column(:state, :active)
  #   end
  # end

  def images?
    images.size.positive?
  end

  def product_attributes=(attributes)
    self.product = Product.find_by(id: attributes[:id])
    super
  end

  def images_attributes=(attributes)
    self.images = Image.where(id: attributes.map{ |attribute| attribute[:id] })
    super
  end

  private

  def default_values
    self.state = state.presence || :unpub
  end

  def check_category
    Category.find(product.category_id_before_last_save).check_variants_counter if product.category_id_before_last_save
    product.category.check_variants_counter
  end

  def cache_sizes
    update_column(:sizes_cache, sizes.map(&:id))
  end


end
