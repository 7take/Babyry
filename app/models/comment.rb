class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :baby

	validates :comment, presence: true
end