class Key < ActiveRecord::Base
  extend ACM::AliasMethodizer

  # A Key has the following attributes.
  #
  # * token (String)        : A _unique_ hash to identify this key.
  #                           This field is user exposable.
  # * expires_on (DateTime) : How long from `created_at` this key is
  #                           valid for. `2.hours` for example.
  # * is_locked (Boolean)   : Forces the key into a invalid state
  #                           when true.
  # * created_at (DateTime)
  # * updated_at (DateTime)

  # We will create that token for the user if it's not provided.
  # The token should always be a secure randomized string.
  before_save do
    self.token ||= SecureRandom.base64
  end

  # Returns true when the key is BOTH unlocked and it's before
  # the `expires_on` datetime.
  def good?
    unlocked? && (self.expires_on ? DateTime.current < self.expires_on : true)
  end

  # Returns true when the key is either locked OR before
  # the `expires_on` datetime.
  def bad?
    !good?
  end

  # Returns true when the key is locked.
  def locked?
    self.is_locked
  end

  # Returns true when the key is not locked.
  def unlocked?
    !locked?
  end

  # Lock this key, rendering it invalid.
  def lock
    self.is_locked = true
  end
  alias_method(:lock!, :lock) { save! }

  # Unlock this key, allowing it to be valid.
  def unlock
    self.is_locked = false
  end
  alias_method(:unlock!, :unlock) { save! }

  # Adds the given amount of time to `expires_on`.
  def extend(time)
    self.expires_on += time
  end
  alias_method(:extend!, :extend) { save! }

  # Removes the given amount of time from `expires_on`.
  def retract(time)
    self.expires_on -= time
  end
  alias_method(:retract!, :retract) { save! }

  # Sets the `expires_on` to now.
  def expire
    self.expires_on = DateTime.current
  end
  alias_method(:expire!, :expire) { save! }

  # Sets the key to not expire.
  def imortalize
    self.expires_on = 1.0/0
  end
  alias_method(:imortalize!, :imortalize) { save! }

end
