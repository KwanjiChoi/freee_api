require_relative '../header/set_header.rb'
require_relative '../company/company.rb'
require 'json'
require 'net/http'
#勘定科目idの取得
class AccountItem
  BASE_URL = 'https://api.freee.co.jp'
  @params = {
    'company_id' => Company.company_id
  }

  def self.account_item_id(name)
    uri = URI.parse(BASE_URL + '/api/1/account_items')
    uri.query =  URI.encode_www_form(@params)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    headers = Header.get_header
    response = http.get(uri.request_uri, headers)
    res_hash = JSON.parse(response.body)
    account_items = res_hash['account_items']
    account_item_id = account_items.select {|x|x['name'].include?(name)}
    account_item_id[0]['id']
  end
end
