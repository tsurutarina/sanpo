class PostComment < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  scope :active, -> { joins(:customer).where('customer.is_deleted': false) }
end
