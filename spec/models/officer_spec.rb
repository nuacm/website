require 'spec_helper'

describe Officer do
  subject { create(:officer) }

  it { should be_a(Member) }
end
