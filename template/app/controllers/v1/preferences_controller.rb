module V1
  class PreferencesController < ApiController
    def index
      body = {
          locale: current_user.preference.locale,
          unit: current_user.preference.unit
      }

      r body: body
    end
  end
end
