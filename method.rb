require 'net/http'
require 'json'
require './lib/params.rb'
require 'uri'

BASE_URL = 'https://api.freee.co.jp'
TOKEN_URL = 'https://accounts.secure.freee.co.jp/public_api/token'

def get_access_token
  uri = URI.parse(TOKEN_URL)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  req = Net::HTTP::Post.new(uri.path)
  req.body = URI.encode_www_form(PARAMS_BODY)
  req.initialize_http_header(PARAMS_HEADER)
  response = http.request(req)
  res_hash = JSON.parse(response.body)
  puts res_hash
  puts response.code
end

def refresh_token
  uri = URI.parse(TOKEN_URL)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  req = Net::HTTP::Post.new(uri.path)
  req.body = URI.encode_www_form(REFRESH_TOKEN_BODY)
  req.initialize_http_header(PARAMS_HEADER)
  response = http.request(req)
  res_hash = JSON.parse(response.body)
  puts res_hash
  puts response.code
end

def get_companies
  uri = URI.parse(BASE_URL + '/api/1/companies')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  headers = USE_ACCESS_TOKEN_HEADER
  response = http.get(uri.path, headers)
  res_hash = JSON.parse(response.body)
  puts res_hash
end


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

def get_torihiki_id(name)
  uri = URI.parse(BASE_URL + '/api/1/partners')
  uri.query = URI.encode_www_form({"company_id" => COMPANY_ID ,'keyword'=> name})
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  headers = USE_ACCESS_TOKEN_HEADER
  response = http.get(uri.request_uri, headers)
  res_hash = JSON.parse(response.body)
  puts res_hash['partners'][0]['id']
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

puts get_torihiki
