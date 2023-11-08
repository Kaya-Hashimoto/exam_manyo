class User < ApplicationRecord
  before_destroy :admin_cannot_delete
  before_update :admin_cannot_update

  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: {maximum: 15}
  validates :email, presence: true, length: {maximum: 255},
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }

  private

  def admin_cannot_update
    if User.where(admin: true).count == 1 && self.admin == false
      errors.add(:base, '管理者は必ず一人必要です')
      throw :abort
    end
  end

  def admin_cannot_delete
    if User.where(admin: true).count == 1 && self.admin == true
      errors.add(:base, '管理者は必ず一人必要です')
      throw :abort
    end
  end
end