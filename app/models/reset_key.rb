class ResetKey < ActiveRecord::Base
  validates :valid_until, :presence => true
  validates :key, :presence => true, :length => { :is => 32 }

  belongs_to :member

  after_initialize { self.key ||= SecureRandom.hex }
end
