class AdminUser < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable

  validates_uniqueness_of :email, case_sensitive: false
end