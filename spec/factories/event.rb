FactoryGirl.define do
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
  end
end
