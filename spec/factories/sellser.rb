FactoryBot.define do

  factory :destination do
    family_name            {"田中"}
    first_name             {"太郎"}
    family_name_kana       {"タナカ"}
    first_name_kana        {"タロウ"}
    post_code              {"00000000"}
    prefecture_id          {"2"}
    city                   {"テスト市"}
    address                {"テスト町"}
    building_name          {"テストビル"}
    phone_number           {"000000000"}
  end

end
