if @order
  json.order do
    json.partial! @order

    json.items @order.items do |item|
      json.partial! item

      json.size do
        json.partial! item.size
      end

      # json.size do
      #   json.partial! item.size
      # end
    end
  end

  json.values do
    json.country @order.country || ''
    json.city @order.city || ''
    json.street @order.street || ''
    json.house @order.house || ''
    json.appartment @order.appartment || ''
    json.comment @order.comment || ''
    json.delivery @order.delivery || ''
    json.delivery_option @order.delivery_option || ''
    json.delivery_city_id @order.delivery_city_id || ''
    json.user_address_id @order.user_address_id || ''

    json.user_attributes do
      json.name @order.user.name || ''
      json.sname @order.user.sname || ''
      json.phone @order.user.phone || ''
      json.email((@order.user.guest_email? ? '' : @order.user.email) || '')
    end
  end

  json.dictionaries do
    json.delivery_cities DeliveryCity.all
    json.user_addresses @order.user.addresses do |address|
      json.extract! address, :id

      json.country address.country || ''
      json.city address.city || ''
      json.street address.street || ''
      json.house address.house || ''
      json.appartment address.appartment || ''
      json.delivery_city_id address.delivery_city_id || ''
      json.delivery_option address.delivery_option || ''

      json.delivery address.delivery_city_id ? :russia : :international
    end
  end
end
