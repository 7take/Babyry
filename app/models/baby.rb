class Baby < ApplicationRecord
	default_scope -> { order(created_at: :desc) }
	belongs_to :user

	has_many :favorites, dependent: :destroy
	has_many :comments, dependent: :destroy

	attachment :image

	with_options presence: true do
		validates :title
		validates :body
		validates :image
	end
end
