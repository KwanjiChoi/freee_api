require_relative '../header/set_header.rb'
require_relative '../company/company.rb'
require 'json'
require 'net/http'
#勘定科目の取得
class AccountItem
  BASE_URL = 'https://api.freee.co.jp'
  @params = {
    'company_id' => Company.company_id
  }

  def self.account_items_id
    uri = URI.parse(BASE_URL + '/api/1/account_items')
    uri.query =  URI.encode_www_form(@params)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    headers = Header.get_header
    response = http.get(uri.request_uri, headers)
    res_hash = JSON.parse(response.body)
  end
end

puts AccountItem.account_items_id
