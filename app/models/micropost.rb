class Micropost < ActiveRecord::Base
  #Relations
  belongs_to :user

  #Validations
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  #Scopes
  default_scope -> { order('created_at DESC') }

  # Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    #followed_user_ids = user.followed_user_ids
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    #where("user_id IN (:followed_user_ids) OR user_id = :user_id", followed_user_ids: followed_user_ids, user_id: user)
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user)
  end
end