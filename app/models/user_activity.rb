class UserActivity < ActiveRecord::Base
  ACTIVITIES = {
    :login => 'user_login'
  }

  attr_accessible :activity, :params, :user_id, :ip
  belongs_to :user

  scope :ordered, order('created_at desc')
end
