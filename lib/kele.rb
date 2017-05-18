class Kele
  include HTTParty

  attr_accessor :email, :password

  def initialize(email, password)
    @email = username
    @password = password
    base_uri "https://www.bloc.io/api/v1"
    self.class.post('/sessions', @email, @password)

    if auth_token != nil
      auth_token = @auth_token
      print "successful authentication"
    else
      print "failure"
    end
  end

end
