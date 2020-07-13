require_relative '../header/set_header.rb'
require_relative '../company/company.rb'
require_relative '../supplier/supplier.rb'
require_relative '../account_items/account_items.rb'
require 'json'
require 'net/http'


class Invoice
  BASE_URL = 'https://api.freee.co.jp'

  def self.make_invoice(params)
    uri = URI.parse(BASE_URL + '/api/1/invoices')
    http = Net::HTTP.new(uri.host,uri.port)
    http.use_ssl = uri.scheme === "https"
    req = Net::HTTP::Post.new(uri.path)
    req.body = params.to_json
    req.initialize_http_header(Header.post_header)
    response = http.request(req)
    res_hash = JSON.parse(response.body)
  end
end
