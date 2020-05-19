FactoryBot.define do
  
  factory :item do
    items_name            {"靴"}
    item_description      {"履きやすい"}
    condition             {"未使用に近い"}
    shipping_costs        {"送料込み(出品者負担)"}
    days_to_ship          {"3~4日で発送"}
    price                 {"400"}
    category_id           {"280"}
    brand_id              {"1"}
    shipping_area_id      {"7"}
  end
end