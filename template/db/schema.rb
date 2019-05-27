ActiveRecord::Schema.define(version: 1) do
  # Extensions
  enable_extension :pgcrypto
  enable_extension :plpgsql

  # Admin: Users
  create_table :admin_users, id: :uuid, force: :cascade do |t|
    t.string :email, null: false, index: true, unique: true
    t.string :encrypted_password, null: false
    t.string :reset_password_token, index: true, unique: true
    t.datetime :reset_password_sent_at
    t.datetime :remember_created_at
    t.timestamps
  end

  # OAuth: Access Tokens
  create_table :oauth_access_tokens, id: :uuid, force: :cascade do |t|
    t.uuid :resource_owner_id, null: false, index: true
    t.uuid :application_id, index: true
    t.string :token, null: false, index: true, unique: true
    t.string :refresh_token, index: true, unique: true
    t.integer :expires_in
    t.datetime :revoked_at
    t.datetime :created_at, null: false
    t.string :scopes
    t.string :previous_refresh_token, default: '', null: false
  end

  # Attatchments
  create_table :active_storage_attachments, force: :cascade do |t|
    t.string :name, null: false
    t.references :record, null: false, polymorphic: true, index: false
    t.references :blob, null: false
    t.datetime :created_at, null: false
    t.index [:record_type, :record_id, :name, :blob_id], name: 'index_active_storage_attachments_uniqueness', unique: true
  end

  # Users
  create_table :users, id: :uuid, force: :cascade do |t|
    t.string :email, null: false, index: true, unique: true
    t.integer :provider, null: false
    t.string :provider_id, null: false, index: true
    t.timestamps
    t.index [:email, :provider, :provider_id], unique: true
  end

  # Preferences
  create_table :preferences, id: false, force: :cascade do |t|
    t.belongs_to :user, type: :uuid, null: false, index: true
    t.integer :locale, null: false, default: 0
    t.integer :unit, null: false, default: 0
  end

  # Profiles
  create_table :profiles, id: false, force: :cascade do |t|
    t.belongs_to :user, type: :uuid, null: false, index: true
    t.string :name, null: false
    t.integer :gender, null: false
    t.date :birthday, null: false
    t.text :avatar, null: false
  end
end
