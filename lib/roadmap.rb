module Roadmap

  def get_roadmap(roadmap_id)
    @roadmap_id = roadmap_id
    response = self.class.get("#{@base_url}/roadmaps/#{@roadmap_id}", headers: { "authorization" => @auth_token } )
    if response != nil
      print "found roadmap"
      roadmap = JSON.parse(response.body)
      roadmap
    else
      print "failure"
    end
  end

  def get_checkpoint(checkpoint_id)
    @checkpoint_id = checkpoint_id
    response = self.class.get("#{@base_url}/checkpoints/#{@checkpoint_id}", headers: { "authorization" => @auth_token } )
    if response != nil
      print "found checkpoint"
      roadmap = JSON.parse(response.body)
      roadmap
    else
      print "failure"
    end
  end

end
