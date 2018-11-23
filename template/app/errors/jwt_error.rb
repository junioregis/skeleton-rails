class JwtError < StandardError
  def initialize(e = 'Jwt error')
    super(e)
  end
end