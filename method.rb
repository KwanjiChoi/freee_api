require 'net/http'
require 'json'
require './lib/params.rb'
require 'uri'

BASE_URL = 'https://api.freee.co.jp'

def make_invoice
  uri = URI.parse(BASE_URL + '/api/1/invoices')
  http = Net::HTTP.new(uri.host,uri.port)
  http.use_ssl = uri.scheme === "https"
  params = INVOICE_PARAMS
  headers = MAKE_INVOICE_HEADER
  req = Net::HTTP::Post.new(uri.path)
  req.body = INVOICE_PARAMS.to_json
  req.initialize_http_header(headers)
  response = http.request(req)
  res_hash = JSON.parse(response.body)
end


def get_torihiki
  torihiki_id = make_invoice['invoice']['deal_id']
  uri = URI.parse(BASE_URL + "/api/1/deals/#{torihiki_id}")
  uri.query = URI.encode_www_form({"company_id" => COMPANY_ID })
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  headers = USE_ACCESS_TOKEN_HEADER
  response = http.get(uri.request_uri, headers)
  res_hash = JSON.parse(response.body)
end

def koushin
  uri = URI.parse(BASE_URL + '/api/1/deals/{id}/renews')
end

puts refresh_token
