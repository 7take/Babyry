class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :babies, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  attachment :profile_image

  validates :username, presence: true

  def already_favorited?(baby)
  	self.favorites.exists?(baby_id: baby.id)
  	#カレントユーザーに結びついてるいいねの中で、baby_idが今いいねしようとしてるbabyのid、これが存在するかどうか
  	#もし存在してる（true）ならいいねを外す、もしfalseならいいねをするボタンに切り替える
  end
end
