class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :babies, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :relationships, foreign_key: "follower_id" # フォロー取得
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id" # フォロワー取得
  has_many :following_users, through: :relationships, source: :followed # 自分がフォローしている人
  has_many :follower_users, through: :reverse_of_relationships, source: :follower # 自分をフォローしている人

  attachment :profile_image

  validates :username, presence: true

  def already_favorited?(baby)
  	self.favorites.exists?(baby_id: baby.id)
  	#カレントユーザーに結びついてるいいねの中で、baby_idが今いいねしようとしてるbabyのid、これが存在するかどうか
  	#もし存在してる（true）ならいいねを外す、もしfalseならいいねをするボタンに切り替える
  end


  def follow(user_id)
    self.relationships.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    self.relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_users.include?(user)
  end
end

