class ResetKey < ActiveRecord::Base

  # Must have a date that tells the key when it expires.
  validates :valid_until, :presence => true

  # Must have a secure key that can be used to validate the
  # member who was emailed.
  validates :key, :presence => true, :length => { :is => 32 }

  # We will setting this field upon creation automatically. Do not
  # allow mass assignment of the key.
  attr_protected :key

  # A member gets assigned a key when they request a password reset.
  # The member is also in charge of disposing of this key when they
  # are finished with it.
  belongs_to :member

  after_initialize do
    # ResetKeys are by default valid for 1 day. This value is
    # not protected and can be set when creating a key.
    self.valid_until ||= DateTime.current + 1.day
    # ResetKey's key value is set to a hex string of length 32.
    # It's set to a new hex value on it's creation, and then it
    # keeps that key until it's deleted.
    self.key ||= SecureRandom.hex
  end

  # expired? -> Boolean
  # Returns true when this key is not longer valid, and should be
  # ignored.
  #
  def expired?
    self.valid_until < DateTime.current
  end
end
