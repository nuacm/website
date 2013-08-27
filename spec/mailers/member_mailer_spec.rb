require "spec_helper"

describe MemberMailer do
  describe "password_reset" do
    let(:member) { member = create(:secure_member) }
    let(:mail) { member.send_password_reset }

    it "sends the message to the right email" do
      mail.to.should include(member.email)
    end

    it "sends the message from the right email" do
      mail.from.should include("noreply@acm.ccs.neu.edu")
    end

    it "renders the right subject" do
      mail.subject.should eq("Password Reset")
    end

    it "renders the body" do
      mail.body.should include edit_password_reset_url(:reset_token =>
                                 member.password_reset_key.token)
    end
  end

end
