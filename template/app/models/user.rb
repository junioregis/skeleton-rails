class User < ApplicationRecord
  has_many :access_tokens, class_name: "Doorkeeper::AccessToken",
           foreign_key: :resource_owner_id,
           dependent: :destroy

  enum provider: {facebook: 0, google: 1}

  has_one :preference, autosave: true, dependent: :destroy
  has_one :profile, autosave: true, dependent: :destroy

  validates_associated :preference, :profile
  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false

  def self.authorize_from_external(data)
    user = User.find_or_create_by(provider: data[:provider], provider_id: data[:provider_id])
    user.email = data[:email]
    user.preference.locale = :pt_BR
    user.preference.unit = :km
    user.profile.name = data[:name]
    user.profile.gender = data[:gender]
    user.profile.birthday = data[:birthday]
    user.profile.avatar = data[:avatar]

    return nil unless user.valid?

    return user if user.save!
  end

  def preference
    super || build_preference
  end

  def profile
    super || build_profile
  end
end
