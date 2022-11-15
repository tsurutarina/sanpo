class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "Customer"
  belongs_to :followed, class_name: "Customer"

  scope :active, -> { where(is_deleted: false) }
end
