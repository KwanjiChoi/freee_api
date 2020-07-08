# headerのセッティング
require_relative '../../key.rb'
class Header
  def self.get_header
    headers = {
      "accept" => "application/json",
      "Authorization"=> "Bearer #{ACCESS_TOKEN}"
    }
    return headers
  end
  def self.post_header
    headers = {
      "accept" => "application/json",
      "Authorization"=> "Bearer #{ACCESS_TOKEN}",
      "Content-Type" => "application/json"
    }
    return headers
  end
end
