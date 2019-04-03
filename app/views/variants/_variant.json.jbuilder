json.extract! variant, :id, :price, :price_last, :price_sell, :color_id

json.category do
  json.extract! variant.product.category, :id, :title, :slug
end

json.product do
  json.extract! variant.product, :id, :title
end

json.images variant.images.sort_by{ |i| [(i.weight.to_i.zero? ? 99 : i.weight), i.created_at] } do |image|
  json.thumb image.photo.thumb.url
  json.large image.photo.large.url
end

json.title variant.product.title.strip
json.image variant.images.sort_by{ |i| [(i.weight.to_i.zero? ? 99 : i.weight), i.created_at] }.first.photo.thumb.url if variant.images.size > 0

json.availabilities_attributes variant.availabilities do |availability|
  json.extract! availability, :id, :variant_id, :size_id, :count, :store_id
  json._destroy false
end
