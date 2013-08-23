require 'spec_helper'

describe Event do

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:start_time) }

  it "validates that start_time is before end_time" do
    bad_event = Event.new :start_time => DateTime.new(2013, 8, 7, 20, 50),
                          :end_time => DateTime.new(2013, 8, 7, 18, 30)
    bad_event.valid?
    bad_event.errors.should include(:end_time)
  end

  it "validates that the title doesn't end in a period" do
    create(:event, :title => "This ends in a period.").should_not be_valid
  end

end
