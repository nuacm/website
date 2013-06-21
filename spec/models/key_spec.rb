require 'spec_helper'

describe Key do
  subject { create(:key) }

  it { should validate_uniqueness_of(:token) }
  it "has a token of about 21 characters" do
    subject.token.length.should be_within(3).of(21)
  end

  describe "good/bad" do
    context "with nil expires_on and not locked" do
      it { should be_good }
    end

    context "with nil expires_on and locked" do
      before { subject.lock! }
      it { should_not be_good }
    end

    context "with a expires_on in the future and not locked" do
      before { subject.expires_on = DateTime.current + 2.days }
      it { should be_good }
    end

    context "with a expires_on in the past and not locked" do
      before { subject.expires_on = DateTime.current - 2.days }
      it { should_not be_good }
    end
  end

end
