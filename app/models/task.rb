class Task < ApplicationRecord
  has_many :labelings, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 250}
  enum status: { "未着手": 0, "着手中": 1, "完了": 2 }

  
end
