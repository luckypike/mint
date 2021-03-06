class Color < ApplicationRecord
  scope :main, -> { where(parent_color: nil) }

  mount_uploader :image, ColorUploader

  belongs_to :parent_color, class_name: 'Color', optional: true
  has_many :colors, class_name: 'Color', foreign_key: :parent_color_id
  has_many :variants

  validates :title_ru, presence: true
  validates :parent_color, absence: true, if: -> { colors.any? }
  validates :color, presence: true, unless: -> { image.presence }

  translates :title
  globalize_accessors locales: I18n.available_locales, attributes: [:title]

  def main?
    !parent_color_id
  end
end
