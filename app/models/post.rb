class Post < ActiveRecord::Base

  belongs_to :author
  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

end
