require 'spec_helper'

describe Officer do
  subject { create(:officer) }
  let(:web_chair) { create(:position, :title => "Web Chair") }

  it { should be_a(Member) }

  it "has a Positions relation" do
    subject.positions << web_chair
    subject.positions.should include(web_chair)
    web_chair.officers.should include(subject)
  end

  it "can have more than 1 Position" do
    subject.positions << web_chair << create(:position, :title => "President")
    subject.positions.count.should eq(2)
  end
end
