class Header
  def self.get_header(access_token)
    headers = {
      "accept" => "application/json",
      "Authorization"=> "Bearer #{access_token}"
    }
    return headers
  end
  def self.post_header
    headers = {
      "accept" => "application/json",
      "Authorization"=> "Bearer #{access_token}",
      "Content-Type" => "application/json"
    }
    return headers
  end
end
