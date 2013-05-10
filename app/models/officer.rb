class Officer < Member
  has_and_belongs_to_many :positions, foreign_key: "member_id"

  def self.model_name
    Member.model_name
  end
end
