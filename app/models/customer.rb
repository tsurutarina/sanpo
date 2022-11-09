class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_one_attached :profile_image

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'user.jpg'
  end

  def self.looks(search, word)
    where("nickname LIKE?", "%#{word}%")
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
