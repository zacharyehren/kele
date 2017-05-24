require 'httparty'
class Kele
  include HTTParty

  attr_accessor :email, :password

  def initialize(email, password)
    @email = email
    @password = password
    @base_url = "https://www.bloc.io/api/v1"
    response = self.class.post("#{@base_url}/sessions", body: { email: email, password: password } )
          
    if response["auth_token"] != nil
      auth_token = @auth_token
      print "successful authentication"
    else
      print "failure"
    end
  end

end
