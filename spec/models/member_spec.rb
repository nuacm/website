require 'spec_helper'

describe Member do
  subject { create(:member) }

  it { should have_many :dues }

  it { should validate_presence_of   :name }
  it { should validate_uniqueness_of :email }
  it { should allow_value("bob.smith@example.com").for(:email) }
  it { should_not allow_value("bob.smith.com").for(:email) }
  it { should_not allow_value("foo").for(:email) }

  describe "Long names" do
    subject { create(:member, :name => "Wolfgang Amadeus Mozart") }

    it "has a one word first name" do
      subject.first_name.should eq("Wolfgang")
    end

    it "has the rest in it's last name" do
      subject.last_name.should eq("Amadeus Mozart")
    end
  end

  describe "Short names" do
    subject { create(:member, :name => "Foobar") }

    it "has a one word first name" do
      subject.first_name.should eq("Foobar")
    end

    it "has no last name" do
      subject.last_name.should be_empty
    end
  end
end
