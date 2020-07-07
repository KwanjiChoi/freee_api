require_relative '../../key.rb'
require 'json'
require 'net/https'


class Token
  PARAMS_HEADER = {
    "Content-Type" => "application/x-www-form-urlencoded"
  }
  CALL_BACK = "urn:ietf:wg:oauth:2.0:oob"
  TOKEN_URL = 'https://accounts.secure.freee.co.jp/public_api/token'
  def initialize(id,secret,code)
    @body = {
      "grant_type": "authorization_code",
      "client_id": "#{id}",
      "client_secret": "#{secret}",
      "code": "#{code}",
      "redirect_uri": "#{CALL_BACK}"
    }
  end

  def get_access_token
    uri = URI.parse(TOKEN_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)
    req.body = URI.encode_www_form(@body)
    req.initialize_http_header(PARAMS_HEADER)
    response = http.request(req)
    res_hash = JSON.parse(response.body)
  end
end


token = Token.new(API_CLIENT,API_KEY,CODE)
puts token.get_access_token
