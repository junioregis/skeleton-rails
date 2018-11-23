class Profile < ApplicationRecord
  self.primary_key = 'user_id'

  enum :gender, { male: 0, female: 1 }

  belongs_to :user

  has_one_attached :avatar

  validates_uniqueness_of :user
  validates_presence_of   :name, :gender
end
