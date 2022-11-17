class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # ユーザーがどの投稿をいいねしてるのか取得
  has_many :favorited_posts, through: :favorites, source: :post
  # フォローした,された
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローフォロワー一覧
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_one_attached :profile_image

  validates :nickname, length: { minimum: 2, maximum: 10 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'user.jpg'
  end

  def self.looks(search, word)
    where("nickname LIKE?", "%#{word}%")
  end
  # フォロー処理
  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end
  # リムーブ処理
  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end
  # フォロしてるか判断
  def following?(customer)
    followings.include?(customer)
  end

  # 退会済みユーザーが同じアカウントでログインできないように
  def active_for_authentication?
    super && (is_deleted == false)
  end

  def self.guest
    find_or_create_by!(nickname: 'ゲストユーザー' ,email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.nickname = "ゲストユーザー"
    end
  end

end
