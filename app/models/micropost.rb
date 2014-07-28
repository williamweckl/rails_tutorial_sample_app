class Micropost < ActiveRecord::Base
  #Relations
  belongs_to :user

  #Validations
  validates :user_id, presence: true

  #Scopes
  default_scope -> { order('created_at DESC') }
end
