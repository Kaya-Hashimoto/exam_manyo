class Task < ApplicationRecord
  scope :latest, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }
  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 250}
end
