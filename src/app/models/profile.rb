class Profile < ApplicationRecord
  self.primary_key = 'user_id'

  belongs_to :user

  has_one_attached :avatar

  GENDER_OPTIONS = %w(male female)

  validates :gender, inclusion: { in: GENDER_OPTIONS }

  validates_uniqueness_of :user
  validates_presence_of :name, :gender, :birthday

  def age
    calc = Date.today.year - birthday.year
    calc -= 1 if Date.today < birthday + calc.years
    calc
  end
end
