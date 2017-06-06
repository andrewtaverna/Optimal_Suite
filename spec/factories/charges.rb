FactoryGirl.define do
  factory :charge do
    user_id 1
amount 1
card_last4 "MyString"
card_type "MyString"
card_exp_month 1
card_exp_year 1
  end

end
