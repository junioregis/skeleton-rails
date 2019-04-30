class AdminUser < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable
end
