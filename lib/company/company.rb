require_relative '../header/set_header.rb'
require 'json'
require 'net/http'


#company_idの取得
class Company
  BASE_URL = 'https://api.freee.co.jp'

  def self.company_id
    uri = URI.parse(BASE_URL + '/api/1/companies')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    headers = Header.get_header
    response = http.get(uri.path, headers)
    res_hash = JSON.parse(response.body)
    res_hash['companies'][0]['id']
  end
end
