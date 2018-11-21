ActiveRecord::Schema.define(version: 1) do
  # Extensions
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  # Users
  create_table :users, id: :uuid, force: :cascade do |t|
    t.string     :email,       null: false, unique: true
    t.string     :provider,    null: false
    t.string     :provider_id, null: false
    t.timestamps
  end

  # Profiles
  create_table :profiles, id: false do |t|
    t.belongs_to :user,     type: :uuid, null: false, index: true
    t.string     :name,     null: false
    t.string     :gender,   null: false
    t.date       :birthday, null: false
  end
  
  # Preferences
  create_table :preferences, id: false do |t|
    t.belongs_to :user,   type: :uuid, null: false, index: true
    t.string     :locale, null: false
    t.string     :unit,   null: false
  end
end
