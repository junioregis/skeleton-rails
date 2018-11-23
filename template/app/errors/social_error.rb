class SocialError < StandardError
  def initialize(e = 'Social error')
    super(e)
  end

  class Facebook < SocialError
    def message
      'Facebook error'
    end
  end

  class Google < SocialError
    def message
      'Google error'
    end
  end
end