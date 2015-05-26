class UserMailer < ActionMailer::Base

  def welcome_email(user)
    recipients    user.email
    from          "Whats Up Raleigh<beta@whatsupraleigh.com>"
    subject       "Thanks for signing up with Whats Up Raleigh"
    sent_on       Time.now
    body          :url=>"http://beta.whatsupraleigh.com/refer/"+user.referral_code.to_s
  end  

end
