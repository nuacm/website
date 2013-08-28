class Officer < SecureMember

  has_and_belongs_to_many :positions, foreign_key: "member_id"
  has_many :posts, :as => :member

  def self.model_name
    Member.model_name
  end
end
