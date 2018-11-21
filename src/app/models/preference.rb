class Preference < ApplicationRecord
  self.primary_key = 'user_id'

  belongs_to :user

  LOCALE_OPTIONS = %w(en_US pt_BR)
  UNIT_OPTIONS   = %w(miles km)

  validates :locale, inclusion: { in: LOCALE_OPTIONS }
  validates :unit,   inclusion: { in: UNIT_OPTIONS }

  validates_uniqueness_of :user
  validates_presence_of   :locale

  before_create do
    self.locale = 'pt_BR'
    self.unit   = 'km'
  end
end
