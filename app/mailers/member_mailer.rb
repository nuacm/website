class MemberMailer < ActionMailer::Base
  default from: "from@example.com"

  def password_reset(member)
    @member = member
    mail :to => member.email, :subject => "Password Reset"
  end
end
