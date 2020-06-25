FactoryBot.define do
  factory :item do
    name                        {"frisk"}
    description                 {"美味しい"}
    price                       {"300"}
    category_id                 {"628"}
    status_id                   {"2"}
    cost_id                     {"1"}
    prefecture_id               {"15"}
    days_id                     {"2"}
    seller_id                   {"1"}
    asocciation :user
  end
end