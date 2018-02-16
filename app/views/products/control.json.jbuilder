json.variants(@variants) do |variant|
  json.extract! variant, :id
  json.color variant.color.title
  json.title variant.product.title
  json.image variant.images.first.photo.preview.url if variant.images.first.present?
end
