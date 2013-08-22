class Post < ActiveRecord::Base

  belongs_to :author, :class_name => "Member", :foreign_key => "member_id"
  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  validates :title, :presence => true
  validates :body, :presence => true
  validates :author, :presence => true

end
