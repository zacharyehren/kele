class Kele
  include HTTParty
  base_uri "https://www.bloc.io/api/v1"

  attr_accessor :username, :password

  def initialize(username, password)
    @username = username
    @password = password
  end

  self.class.post('/sessions', @username, @password)

end
