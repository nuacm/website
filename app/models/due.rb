class Due < ActiveRecord::Base
  belongs_to :member

  validates :amount, :presence => true

  def good_till
    before_september = self.created_at < Date.new(self.created_at.year, 9, 1)
    if before_september
      Date.new(self.created_at.year, 9, 1)
    else
      Date.new(self.created_at.year + 1, 9, 1)
    end
  end

  def expired?
    Date.today > self.good_till
  end
end
