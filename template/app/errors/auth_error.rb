class AuthError < StandardError
  def initialize(e = 'Auth error')
    super(e)
  end

  class InvalidProvider < AuthError
    def message
      'Invalid provider'
    end
  end

  class UserNotFound < AuthError
    def message
      'User not found'
    end
  end
end