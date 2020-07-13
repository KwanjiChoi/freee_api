require_relative '../header/set_header.rb'
require_relative '../company/company.rb'
require 'json'
require 'net/http'

class Torihiki
  BASE_URL = 'https://api.freee.co.jp'
  @params = {
    'company_id' => Company.company_id
  }
  def self.target_id(id)
    uri = URI.parse(BASE_URL + "/api/1/deals/#{id}")
    http = Net::HTTP.new(uri.host, uri.port)
    uri.query = URI.encode_www_form(@params)
    http.use_ssl = true
    headers = Header.get_header
    response = http.get(uri.request_uri, headers)
    res_hash = JSON.parse(response.body)
    res_hash['deal']['details'][0]['id']
  end
end
#
# renew_target_id = Torihiki.target_id(647400745)
# #取引行idの取得
# puts renew_target_id
