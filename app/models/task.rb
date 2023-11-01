class Task < ApplicationRecord
  has_many :labelings, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 250}
  enum status: { "未着手": 0, "着手中": 1, "完了": 2 }


  scope :search_title, -> (search){ where('title like ?', "%#{search}%") if search.present? }
  scope :search_status, -> (status){ where(status: status) if status.present? }
end