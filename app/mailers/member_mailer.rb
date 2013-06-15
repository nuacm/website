class MemberMailer < ActionMailer::Base
  default from: "noreply@acm.ccs.neu.edu"

  def password_reset(member)
    @member = member
    mail :to => member.email, :subject => "Password Reset"
  end
end
