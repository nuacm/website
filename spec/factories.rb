FactoryGirl.define do

  # Sequences

  sequence :email do |n|
    "email#{n}@example.com"
  end

  # Factories

  factory :key

  factory :member do
    name 'Billy Black'
    email
    password 'ziRon^fo1'
    password_confirmation 'ziRon^fo1'

    factory :officer, :class => Officer do
      after(:create) do |officer, evaluator|
        officer.positions << create(:position)
      end
    end
  end

  factory :position do
    title { "Position#{rand(100)}" }
  end

  factory :event do
    title 'Intro to Rails'
    description <<-EOS
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute
irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia
deserunt mollit anim id est laborum.
    EOS
    start_time DateTime.new(2013, 8, 7, 18, 30)  # year, month, day, hour, minute.
    end_time DateTime.new(2013, 8, 7, 19, 30)  # year, month, day, hour, minute.
    location "102 WVH"

    factory :talk, :class => Talk do
      talker "Nathan Lilienthal"
    end
  end

end
