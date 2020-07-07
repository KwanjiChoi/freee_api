require_relative '../params.rb'
require 'json'
require 'net/http'

#company_idの取得
class Company
  BASE_URL = 'https://api.freee.co.jp'
  
  def self.get_company_id(access_token)
    uri = URI.parse(BASE_URL + '/api/1/companies')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    headers = {
      "accept" => "application/json",
      "Authorization"=> "Bearer #{access_token}"
    }
    response = http.get(uri.path, headers)
    res_hash = JSON.parse(response.body)
    res_hash['companies'][0]['id']
  end
end

puts Company.get_company_id(ACCESS_TOKEN)
