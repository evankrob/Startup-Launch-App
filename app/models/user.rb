class User < ActiveRecord::Base
has_many :referrals
has_many :new_users, :through => :referrals

validates_uniqueness_of :email, :message => "- This email address has already been used to sign up!"
validates_format_of :email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i

end

