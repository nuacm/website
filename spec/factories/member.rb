FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@example.com"
  end

  factory :member do
    full_name 'Billy Black'
    email
    password "foobar"
    password_confirmation "foobar"
  end
end