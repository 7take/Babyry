class Favorite < ApplicationRecord
	belongs_to :user
	belongs_to :baby

	validates_uniqueness_of :baby_id, scope: :user_id
end
