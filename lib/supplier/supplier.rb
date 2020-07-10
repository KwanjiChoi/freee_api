require_relative '../header/set_header.rb'
require_relative '../company/company.rb'
#取引先idの取得
class Supplier
  BASE_URL = 'https://api.freee.co.jp'

  def self.supplier_id(name)
    uri = URI.parse(BASE_URL + '/api/1/partners')
    uri.query = URI.encode_www_form({'company_id' => Company.company_id,'keyword' => name})
    http = Net::HTTP.new(uri.host,uri.port)
    http.use_ssl = true
    headers = Header.get_header
    response = http.get(uri.request_uri, headers)
    res_hash = JSON.parse(response.body)
    res_hash['partners'][0]['id']
  end
end

puts Supplier.supplier_id('CFO')
