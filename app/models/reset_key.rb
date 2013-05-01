class ResetKey < ActiveRecord::Base
  validates :valid_until, :presence => true
  validates :key, :presence => true, :length => { :is => 32 }

  after_initialize { self.key = SecureRandom.hex }
end
