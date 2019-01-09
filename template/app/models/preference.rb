class Preference < ApplicationRecord
  self.primary_key = 'user_id'

  enum locale: {pt_BR: 0}
  enum unit: {km: 0}

  belongs_to :user

  validates_uniqueness_of :user
  validates_presence_of :locale, :unit
end
