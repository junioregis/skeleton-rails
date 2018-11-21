class User < ApplicationRecord
  has_one :preference, autosave: true, dependent: :destroy
  has_one :profile,    autosave: true, dependent: :destroy

  validates_associated    :preference, :profile
  validates_presence_of   :email
  validates_uniqueness_of :email, case_sensitive: false

  def preference
    super || build_preference
  end

  def profile
    super || build_profile
  end
end
