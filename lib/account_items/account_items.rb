require_relative '../header/set_header.rb'
require_relative '../company/company.rb'
require 'json'
require 'net/http'

class AccountItem
  BASE_URL = 'https://api.freee.co.jp'
  attr_accessor :params
  @params = {
    'company_id' => Company.company_id
  }

  def self.account_item_id
    uri = URI.parse(BASE_URL + '/api/1/account_items')
    uri.query =  URI.encode_www_form(@params)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    headers = Header.get_header
    response = http.get(uri.request_uri, headers)
    res_hash = JSON.parse(response.body)
  end

end
