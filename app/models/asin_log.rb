class AsinLog < ActiveRecord::Base
  belongs_to :asin

  validates :asin_id, :price presence: true
end
