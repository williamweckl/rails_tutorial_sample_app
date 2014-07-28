class Micropost < ActiveRecord::Base
  #Relations
  belongs_to :user

  #Validations
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  #Scopes
  default_scope -> { order('created_at DESC') }
end
