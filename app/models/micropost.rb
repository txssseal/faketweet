class Micropost < ActiveRecord::Base
	belongs_to :user  #this is the relation
	default_scope -> { order('created_at DESC') } #orders the microposts in descending order
	validates :content, presence: true, length: { maximum: 140 }
	validates :user_id, presence: true #makes sure user id is present
end
