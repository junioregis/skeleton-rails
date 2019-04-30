module V1
  class ProfilesController < ApiController
    def me
      body = {
          id: current_user.id,
          name: current_user.profile.name,
          gender: current_user.profile.gender,
          age: current_user.profile.age,
          avatar: current_user.profile.avatar
      }

      r body: body
    end
  end
end
