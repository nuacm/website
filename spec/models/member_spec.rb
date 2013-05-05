require 'spec_helper'

describe Member do
  subject { create(:member) }

  it { should validate_presence_of   :full_name }
  it { should validate_presence_of   :email }
  it { should validate_uniqueness_of :email }
  it { should allow_value("bob.smith@example.com").for(:email) }
  it { should_not allow_value("bob.smith.com").for(:email) }
  it { should_not allow_value("foo").for(:email) }

  describe "reset_key" do
    before { ResetKey.destroy_all }

    it { should have_one(:reset_key) }

    it "sets a reset_key on #forgot_password the first time" do
      subject.reset_key.should eq(nil)
      subject.forgot_password!
      subject.reset_key.should be_a(ResetKey)
    end

    it "sets reset_key on #forgot_password!" do
      subject.forgot_password!
      old_reset_key = subject.reset_key
      subject.forgot_password!
      subject.reset_key.should_not eq(old_reset_key)
    end

    it "will destroy old keys before creating new ones" do
      ResetKey.count.should eq(0)
      subject.forgot_password!
      ResetKey.count.should eq(1)
      subject.forgot_password!
      ResetKey.count.should eq(1)
    end
  end

  describe "setting new password with ResetKey" do
    context "when given valid key" do
      it "can set a new password" do
        subject.forgot_password!
        subject.update_password "billybob", "billybob", :key => subject.reset_key.key
        subject.reload.password.should eq("billybob")
      end
    end

    context "when given a invalid ResetKey" do
      it "that is out of date, dosn't set password" do
        subject.forgot_password!
        subject.reset_key.valid_until = DateTime.current - 1.week
        expect { subject.update_password "billybob", "billybob", :key => subject.reset_key.key }.to raise_error
        subject.reload.password.should_not eq("billybob")
      end

      it "that has wrong key, dosn't set password" do
        expect { subject.update_password "billybob", "billybob", :key => ResetKey.new.key }.to raise_error
        subject.reload.password.should_not eq("billybob")
      end

      it "that has no key, dosn't set password" do
        expect { subject.update_password "billybob", "billybob", :key => nil }.to raise_error
        subject.reload.password.should_not eq("billybob")
      end
    end
  end
end
