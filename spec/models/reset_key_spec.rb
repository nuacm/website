require 'spec_helper'

describe ResetKey do
  subject { create(:reset_key) }

  it { should validate_presence_of :valid_until }
  it { should validate_presence_of :key }
  it { should ensure_length_of(:key).is_equal_to(32) }

  it { should belong_to(:member) }

  it "allows custom values for valid_until" do
    datetime = DateTime.current + 1.week
    subject = create(:reset_key, :valid_until => datetime)
    subject.valid_until.should eq(datetime)
  end

  it "persists it's key" do
    second_instance = ResetKey.find(subject.id)
    second_instance.key.should eq(subject.key)
  end

  it "persists it's valid_until" do
    second_instance = ResetKey.find(subject.id)
    second_instance.valid_until.to_i.should eq(subject.valid_until.to_i)
  end
end
