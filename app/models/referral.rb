class Referral < ActiveRecord::Base
belongs_to :user
belongs_to :new_users, :class_name => "User", :foreign_key => "new_user"
end
