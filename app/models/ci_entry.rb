class CiEntry < ApplicationRecord
  belongs_to :ci_month
  belongs_to :user
  validates :content, presence: true
  validates :date, presence: true
end
