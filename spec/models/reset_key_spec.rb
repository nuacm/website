require 'spec_helper'

describe ResetKey do
  subject { create(:reset_key) }

  it { should validate_presence_of :valid_until }
  it { should validate_presence_of :key }
  it { should ensure_length_of(:key).is_equal_to(32) }

  it { should belong_to(:member) }

  it "persists it's key" do
    value = subject.key
    second_instance = ResetKey.find(subject.id)
    second_instance.key.should eq(subject.key)
  end
end
