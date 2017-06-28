class Product < ApplicationRecord
  mount_uploaders :images, ImageUploader

  has_many :kitables
  has_many :kits, through: :kitables

  belongs_to :category

  has_many :variants, inverse_of: :product
  accepts_nested_attributes_for :variants

  validates_presence_of :title, :price

  def title
    "#P#{id} - #{category.title}"
  end

  class << self
  end
end
