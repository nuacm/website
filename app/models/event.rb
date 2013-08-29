class Event < ActiveRecord::Base
  default_scope { order("start_time ASC") }

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  validates :title, :presence => true, :punctuation => { :without => '\.' }
  validates :description, :presence => true
  validates :location, :presence => true
  validates :start_time, :presence => true
  validate :end_time_after_start_time

  def self.upcoming
    where ["start_time >= ?", DateTime.current.midnight]
  end

  def self.past
    where ["start_time < ?", DateTime.current.midnight]
  end

  private

  def end_time_after_start_time
    if self.start_time && self.end_time && self.start_time > self.end_time
      errors.add(:end_time, "must be after start time")
    end
  end

end
