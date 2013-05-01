require 'spec_helper'

describe Member do
  subject { create(:member) }

  it { should validate_presence_of   :full_name }
  it { should validate_uniqueness_of :email }
  it { should allow_value("bob.smith@example.com").for(:email) }
  it { should_not allow_value("bob.smith.com").for(:email) }
  it { should_not allow_value("foo").for(:email) }

  describe "reset_key" do
    before { ResetKey.destroy_all }

    it { should have_one(:reset_key) }

    it "sets a reset_key of #forgot_password the first time" do
      subject.reset_key.should eq(nil)
      subject.forgot_password!
      subject.reset_key.should be_a(ResetKey)
    end

    it "sets reset_key on #forgot_password!" do
      subject.forgot_password!
      old_key = subject.reset_key
      subject.forgot_password!
      subject.reset_key.should_not eq(old_key)
    end

    it "will destroy old keys before creating new ones" do
      ResetKey.count.should eq(0)
      subject.forgot_password!
      ResetKey.count.should eq(1)
      subject.forgot_password!
      ResetKey.count.should eq(1)
    end
  end
end
