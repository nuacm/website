class Post < ActiveRecord::Base

  belongs_to :member
  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  validates :title, :presence => true, :punctuation => { :without => '\.' }
  validates :body, :presence => true
  validates :member, :presence => true

end
