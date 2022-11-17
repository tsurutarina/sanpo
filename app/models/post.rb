class Post < ApplicationRecord
  belongs_to :customer

  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # 投稿がだれにいいねされているか取得
  has_many :favorited_customers, through: :favorites, source: :customer

  validates :address_spot, presence: true
  validates :spot_name, presence: true
  validates :body, presence: true, length: {maximum:200}

  has_one_attached :spot_image

  def get_spot_image
    unless spot_image.attached?
      file_path = Rails.root.join('app/assets/images/spot.jpg')
      spot_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
  end

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  def self.looks(search, word)
    where("spot_name LIKE?", "%#{word}%")
  end

end
