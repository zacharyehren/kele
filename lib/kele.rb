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
      if nil != response
        parse_json(response)
      else
        print "failure"
      end
    end

    def get_mentor_availability(mentor_id)
      @mentor_id = mentor_id
      response = self.class.get("#{@base_url}/mentors/#{@mentor_id}/student_availability", headers: { "authorization" => @auth_token } )
      if nil != response
        parse_json(response)
      else
        print "failure"
      end
    end

    def get_messages(page = nil)
      response = self.class.get("#{@base_url}/message_threads?page=#{page}", headers: { "authorization" => @auth_token } )
      if nil == page
        response = self.class.get("#{@base_url}/message_threads", headers: { "authorization" => @auth_token } )
        parse_json(response)
      elsif nil != response
        parse_json(response)
      else
        print "failure"
      end
    end

    def create_messages(recipient_id, token, subject, stripped_text)
      values = {
      sender: @email,
      recipient_id: recipient_id,
      token: token,
      subject: subject,
      'stripped-text' => stripped_text
    }
      response = self.class.post("#{@base_url}/messages", headers: { "authorization" => @auth_token }, body: { sender: @email, recipient_id: recipient_id, token: token, subject: subject, 'stripped-text' => stripped_text } )
    end

    def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
      response = self.class.post("#{@base_url}/checkpoint_submissions", headers: { "authorization" => @auth_token }, body: { checkpoint_id: checkpoint_id, assignment_branch: assignment_branch, assignment_commit_link: assignment_commit_link, enrollment_id: enrollment_id, 'comment' => comment } )
    end

private

  def parse_json(response)
    print "found messages"
    json = JSON.parse(response.body)
    json
  end

end
