class Post < ApplicationRecord
  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :spot_image



  def get_spot_image
    unless spot_image.attached?
      file_path = Rails.root.join('app/assets/images/spot.jpg')
      spot_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
  end

  def self.looks(search, word)
    where("spot_name LIKE?", "%#{word}%")
  end

end
