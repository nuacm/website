class Officer < Member
  has_and_belongs_to_many :positions, foreign_key: "member_id"
end
