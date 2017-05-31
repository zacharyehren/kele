require 'httparty'
require_relative 'roadmap'
class Kele
  include HTTParty
  include Roadmap

  attr_accessor :email, :password, :base_url

  def initialize(email, password)
    @email = email
    @password = password
    @base_url = "https://www.bloc.io/api/v1"
    response = self.class.post("#{@base_url}/sessions", body: { email: email, password: password } )

    if response["auth_token"] != nil
      @auth_token = response["auth_token"]
      print "successful authentication"
    else
      print "authentication failed"
    end
  end

  def get_me
    response = self.class.get("#{@base_url}/users/me", headers: { "authorization" => @auth_token } )
      if response != nil
        print "success"
        user = JSON.parse(response.body)
        user
      else
        print "failure"
      end
    end

    def get_mentor_availability(mentor_id)
      @mentor_id = mentor_id
      response = self.class.get("#{@base_url}/mentors/#{@mentor_id}/student_availability", headers: { "authorization" => @auth_token } )
      if response != nil
        print "found mentor"
        availability = JSON.parse(response.body)
        availability
      else
        print "failure"
      end
    end

    def get_messages(number)
      response = self.class.get("#{@base_url}/message_threads", headers: { "authorization" => @auth_token } )
      if response != nil
        print "found messages"
        message_page_number = response[ values: { "page" => number } ]
        messages = JSON.parse(message_page_number)
        messages
      else
        print "failure"
      end
    end

    # def create_messages (recipient_id, token, subject, stripped_text)
    #   response = self.class.post("#{@base_url}/messages", headers: { "authorization" => @auth_token } )
    #   values = {
    #   sender: @email,
    #   recipient_id: @mentor_id,
    #   token:
    #   subject:
    #   stripped_text:
    # }
    #
    #   if response != nil
    #     print "found messages"
    #     messages = JSON.parse(response.body)
    #     messages
    #   }
    #   else
    #     print "failure"
    #   end
    # end




end
