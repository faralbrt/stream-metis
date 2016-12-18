class Asin < ActiveRecord::Base
  has_many :logs, class_name: :AsinLog

  validates :name, presence: true, uniqueness: true, length: {is: 10}
end
