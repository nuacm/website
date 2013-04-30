require 'spec_helper'

describe Member do
  subject { create(:member) }

  it { should validate_presence_of   :full_name }
  it { should validate_uniqueness_of :email }
end
