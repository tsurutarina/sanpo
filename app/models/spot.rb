class Spot < ApplicationRecord
  # belongs_to :post
  # # geocoded_by :address
  # # after_validation :geocode

  # has_one_attached :spot_image

  # def get_spot_image# (width, height)
  #   unless spot_image.attached?
  #     file_path = Rails.root.join('app/assets/images/spot.jpg')
  #     spot_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  #   end
  #   item_image#.variant(resize_to_limit: [width, height]).processed
  # end

  # validates :latitude, presence: true
  # validates :longitude, presence: true

end
