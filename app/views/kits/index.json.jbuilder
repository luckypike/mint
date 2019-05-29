json.kits @kits do |kit|
  json.id kit.id
  json.title kit.human_title
  json.variants kit.variants.size
  json.images kit.images.first(3).map{|i| i.photo.thumb.url}
end
