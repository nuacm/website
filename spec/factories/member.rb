FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@example.com"
  end

  factory :member do
    name 'Billy Black'
    email
    password 'ziRon^fo1'
    password_confirmation 'ziRon^fo1'
  end
end
