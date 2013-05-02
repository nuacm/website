require 'spec_helper'

describe ResetKey do
  subject { create(:reset_key) }

  it { should validate_presence_of :valid_until }
  it { should validate_presence_of :key }
  it { should ensure_length_of(:key).is_equal_to(32) }

  it { should belong_to(:member) }

  it { should allow_mass_assignment_of(:valid_until) }
  it { should_not allow_mass_assignment_of(:key) }

  it "persists it's key" do
    second_instance = ResetKey.find(subject.id)
    second_instance.key.should eq(subject.key)
  end

  it "persists it's valid_until" do
    second_instance = ResetKey.find(subject.id)
    second_instance.valid_until.to_i.should eq(subject.valid_until.to_i)
  end

  it "knows when it's expired" do
    subject.should_not be_expired
    Timecop.freeze(DateTime.current + 1.day) do
      subject.should be_expired
    end
  end
end
