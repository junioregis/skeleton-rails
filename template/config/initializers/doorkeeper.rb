Doorkeeper.configure do
  api_only
  grant_flows %w(password assertion refresh_token)
  access_token_expires_in 5.days
  use_refresh_token

  resource_owner_from_assertion do
    case params[:provider]
    when 'facebook'
      g = FacebookService.new(params[:assertion])
      g.get_user!
    when 'google'
      g = GoogleService.new(params[:assertion])
      g.get_user!
    else
      nil
    end
  end

  skip_authorization do
    true
  end
end
