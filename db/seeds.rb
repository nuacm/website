case Rails.env
when "development"
  require "factory_girl_rails"
  require "faker"

  5.times { FactoryGirl.create(:position) }
  25.times { FactoryGirl.create(:tag) }

  your_name = Etc.getlogin
  you = FactoryGirl.create :officer, :name => your_name,
                                     :email => "#{your_name}@ccs.neu.edu",
                                     :password => "password"

  100.times { FactoryGirl.create(:member) }
  10.times { FactoryGirl.create(:event) }
  20.times { FactoryGirl.create(:talk) }
  20.times { FactoryGirl.create(:post) }
  5.times do
    FactoryGirl.create(:post, :member => you)
  end

  10.times { FactoryGirl.create(:tagging) }
when "production"
  # maybe one day we'll need this.
end