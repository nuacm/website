class Member < ActiveRecord::Base
  has_many :dues

  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :email => true

  after_create { subscribe_to("ACM Members") if Rails.env == "production" }
  after_destroy { unsubscribe_from("ACM Members") if Rails.env == "production" }

  # subscribe_to String ->
  def subscribe_to(list_name)
    list = Gibbon::API.lists.list({ :filters => { :list_name => list_name } })['data'].first
    name_parts = self.name.split(' ')
    request = {
      :id => list['id'],
      :email => { :email => self.email },
      :merge_vars => { :FNAME => name_parts[0], :LNAME => name_parts[1..-1].join(' ') },
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
