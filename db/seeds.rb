case Rails.env
when "development"

  # Create a Position for your Officer.
  position = Position.where(:title => "Bishop").first_or_create

  # Create a few Tags to have handy.
  tags = [:code, :startup, :ruby, :rails, :avr, :social, :games]
  tags.each do |tag|
    Tag.find_or_create_by_name(tag)
  end

  # Create a development Officer.
  if Officer.count == 0
    your_name = Etc.getlogin
    you = Officer.create :name => your_name,
                   :email => "#{your_name}@ccs.neu.edu",
                   :password => "password",
                   :password_confirmation => "password",
                   :positions => [position]
  end

  # Create a development basic Member.
  if Member.count <= 1
    Member.create :name => "Jill Hoft",
                  :email => "jill-hoft@example.com",
                  :password => "i-suck@passw0rds",
                  :password_confirmation => "i-suck@passw0rds"
  end

  if Talk.count == 0
    Talk.create :title => "Embedded Ruby",
                :description => "Write ruby for the embedded world.",
                :location => "104 WVG",
                :start_time => DateTime.new(2014,01,6,18,00),
                :end_time => DateTime.new(2014,01,6,19,00),
                :talker => "Paul Newman",
                :taggings => [
                  Tagging.create(:tag => Tag.find_by_name(:code)),
                  Tagging.create(:tag => Tag.find_by_name(:ruby)),
                  Tagging.create(:tag => Tag.find_by_name(:avr))
                ]
  end

  if Event.count <= 1
    Event.create :title => "CCS CS Competition",
                 :description => "Compete to be the best CS player at NU.",
                 :location => "102 WVH",
                 :start_time => DateTime.new(2014,03,12,18,30),
                 :end_time => DateTime.new(2014,03,12,20,30),
                 :taggings => [
                   Tagging.create(:tag => Tag.find_by_name(:social)),
                   Tagging.create(:tag => Tag.find_by_name(:games))
                 ]
  end

when "production"
  # maybe one day we'll need this.
end