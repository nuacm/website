require 'spec_helper'

describe Due do
  it { should have_attribute :amount }

  it { should belong_to :member }

  it { should validate_presence_of(:amount) }
  it { should respond_to :good_until }
  it { should respond_to :expired? }

  context "created before September 1st of this year" do
    subject { create(:due) }

    before do
      Timecop.travel(Date.new(Date.today.year, 8, 8))
    end

    it "is good until September 1st of this year" do
      subject.good_until.should == Date.new(Date.today.year, 9, 1)
    end
  end

  context "created after September 1st of this year" do
    subject { create(:due) }

    before do
      Timecop.travel(Date.new(Date.today.year, 11, 11))
    end

    it "is good until September 1st of next year" do
      subject.good_until.should == Date.new(Date.today.year + 1, 9, 1)
    end
  end

  it "is expired after September 1st of the following year" do
    Timecop.travel(Date.new(Date.today.year, 9, 9))
    subject = create(:due)
    Timecop.travel(Date.new(Date.today.year + 1, 10, 10))
    subject.should be_expired
  end

  it "is not expired before September 1st of the following year" do
    Timecop.travel(Date.new(Date.today.year, 9, 9))
    subject = create(:due)
    Timecop.travel(Date.new(Date.today.year, 10, 10))
    subject.should_not be_expired
  end
end
