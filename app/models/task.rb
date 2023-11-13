class Task < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 250}
  enum status: { "未着手": 0, "着手中": 1, "完了": 2 }
  enum priority: { "低": 0, "中": 1, "高": 2 }
  scope :search_title, -> (search){ where('title like ?', "%#{search}%") if search.present? }
  scope :search_status, -> (status){ where(status: status) if status.present? }
  scope :search_label, -> (label){ joins(:labels).where('labels.id = ?', label) if label.present? }
  paginates_per 5
end