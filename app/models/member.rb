class Member < ActiveRecord::Base
  has_secure_password

  validates :full_name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :email => true

  before_create { generate_unique_token(:auth_token) }

  # generate_unique_token : Symbol ->
  # Generates a unique token and sets it to the given attribute.
  def generate_unique_token(attribute)
    begin
      self[attribute] = SecureRandom.urlsafe_base64
    end while Member.exists?(attribute => self[attribute])
  end
end
