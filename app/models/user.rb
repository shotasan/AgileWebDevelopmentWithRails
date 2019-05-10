class User < ApplicationRecord
  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password

  private

  def ensure_an_admin_remains
    if User.count.zero?
      raise '最後のユーザは削除できません'
    end
  end
end
