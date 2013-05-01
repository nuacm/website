FactoryGirl.define do
  factory :reset_key do
    valid_until DateTime.current + 1.day
  end
end