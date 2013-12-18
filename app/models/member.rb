class Member < ActiveRecord::Base
  has_many :dues

  accepts_nested_attributes_for :dues, :allow_destroy => true,
                                       :reject_if => :all_blank

  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :email => true

  after_create { subscribe_to("ACM Members") if Rails.env == "production" }
  after_destroy { unsubscribe_from("ACM Members") if Rails.env == "production" }

  # first_name -> String
  def first_name
    self.name.split(' ')[0]
  end

  # last_name -> String
  def last_name
    self.name.split(' ')[1..-1].join(' ')
  end

  # subscribe_to String ->
  def subscribe_to(list_name)
    list = Gibbon::API.lists.list({ :filters => { :list_name => list_name } })['data'].first
    request = {
      :id => list['id'],
      :email => { :email => self.email },
      :merge_vars => { :FNAME => self.first_name, :LNAME => self.last_name },
    }
    Gibbon::API.lists.subscribe(request)
  end

  # unsubscribe_from String ->
  def unsubscribe_from(list_name)
    list = Gibbon::API.lists.list({ :filters => { :list_name => list_name } })['data'].first
    request = {
      :id => list['id'],
      :email => { :email => self.email },
    }
    Gibbon::API.lists.unsubscribe(request)
  end
end
