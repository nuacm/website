class Talk < Event

  validates :talker, :presence => true

  def self.model_name
    Event.model_name
  end

end