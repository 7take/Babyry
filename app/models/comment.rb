class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :baby

	validates :comment, length: {maximum: 39, minimum: 1}, presence: true
end
