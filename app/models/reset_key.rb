class ResetKey < ActiveRecord::Base
  attr_protected :key

  validates :valid_until, :presence => true
  validates :key, :presence => true, :length => { :is => 32 }

  belongs_to :member

  # Set default values.
  after_initialize do
    self.valid_until ||= DateTime.current + 1.day
    self.key         ||= SecureRandom.hex
  end

  def expired?
    self.valid_until < DateTime.current
  end
end
