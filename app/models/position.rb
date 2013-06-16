class Position < ActiveRecord::Base
  has_and_belongs_to_many :officers, association_foreign_key: "member_id"
end
