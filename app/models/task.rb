class Task < ApplicationRecord
  has_many :labelings, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 250}
  enum status: { status_not_started: 0, status_start: 1, status_complete: 2 }
end
