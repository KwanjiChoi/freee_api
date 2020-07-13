require_relative '../../key.rb'
require 'json'
require 'net/http'


class Token
  PARAMS_HEADER = {
    "Content-Type" => "application/x-www-form-urlencoded"
  }
  CALL_BACK = "urn:ietf:wg:oauth:2.0:oob"
  TOKEN_URL = 'https://accounts.secure.freee.co.jp/public_api/token'
  def initialize(id,secret,code)
    @id = id
    @secret = secret
    @code = code
    @body = {
      "grant_type": "authorization_code",
      "client_id": "#{@id}",
      "client_secret": "#{@secret}",
      "code": "#{@code}",
      "redirect_uri": "#{CALL_BACK}"
    }

    raise 'アプリケーションIDが入力されていません' if id.empty?
    raise 'Secretが入力されていません' if secret.empty?
  end

  #アクセストークンの取得
  def get_access_token
    uri = URI.parse(TOKEN_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)
    req.body = URI.encode_www_form(@body)
    req.initialize_http_header(PARAMS_HEADER)
    response = http.request(req)
    return res_hash = JSON.parse(response.body)
  end

  #アクセストークンの更新
  def refresh_token(refresh_token)
     refresh_body = {
       "grant_type": "refresh_token",
       "client_id": "#{@id}",
       "client_secret": "#{@secret}",
       "refresh_token": "#{refresh_token}"
     }
     uri = URI.parse(TOKEN_URL)
     http = Net::HTTP.new(uri.host, uri.port)
     http.use_ssl = true
     req = Net::HTTP::Post.new(uri.path)
     req.body = URI.encode_www_form(refresh_body)
     req.initialize_http_header(PARAMS_HEADER)
     response = http.request(req)
     return res_hash = JSON.parse(response.body)
  end
end


# token = Token.new(API_CLIENT,API_KEY,CODE)
# puts token.refresh_token(REFRESH_TOKEN)
