module V1
  class ProfilesController < ApiController
    def me
      body = { 
        name:   current_user.profile.name,
        gender: current_user.profile.gender,
        age:    current_user.profile.age,
        avatar: rails_blob_url(current_user.profile.avatar)
      }

      r body: body
    end
  end
end
