class Profile < ApplicationRecord
  self.primary_key = 'user_id'

  enum gender: { male: 0, female: 1 }

  belongs_to :user

  validates_uniqueness_of :user
  validates_presence_of   :name, :gender, :birthday, :avatar
end
