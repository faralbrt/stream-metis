class AsinLog < ActiveRecord::Base
  belongs_to :asin

  validates :asin_id, :price, presence: true

  def self.todays_records
    records = AsinLog.where("created_at >= ? AND created_at <= ?", Time.now.beginning_of_day, Time.now.tomorrow.beginning_of_day)
    records.sort_by{|record| record.title}
  end
end
