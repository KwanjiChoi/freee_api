require_relative '../header/set_header.rb'
require_relative '../company/company.rb'
require_relative '../supplier/supplier.rb'
require_relative '../account_items/account_items.rb'
require 'json'
require 'net/http'
require 'date'


class Invoice
  BASE_URL = 'https://api.freee.co.jp'
  @params = {
    "company_id": Company.company_id,
    "issue_date": Date.today,
    "due_date": Date.new(Time.now.year, Time.now.month, -1),
    "partner_id": Supplier.supplier_id('CFO'),
    "booking_date": Date.today,
    "description": "#{Date.today.month}月分請求書",
    "invoice_status": "issue",
    "partner_display_name": "株式会社freeeパートナー",
    "partner_title": "御中",
    "partner_contact_info": "営業担当",
    "partner_zipcode": "012-0009",
    "partner_prefecture_code": 4,
    "partner_address1": "湯沢市",
    "partner_address2": "Aビル",
    "company_name": "freee株式会社",
    "company_zipcode": "000-0000",
    "company_prefecture_code": 12,
    "company_address1": "ＸＸ区ＹＹ１−１−１",
    "company_address2": "ビル 1F",
    "company_contact_info": "法人営業担当",
    "payment_type": "transfer",
    "payment_bank_info": "ＸＸ銀行ＹＹ支店 1111111",
    "message": "下記の通りご請求申し上げます。",
    "notes": "毎度ありがとうございます",
    "invoice_layout": "default_classic",
    "tax_entry_method": "exclusive",
    "invoice_contents": [
      {
        "order": 0,
        "type": "normal",
        "qty": 1,
        "unit": "個",
        "unit_price": 12000,
        "vat": 1200,
        "description": "備考",
        "tax_code": 1,
        "account_item_id": AccountItem.account_item_id('前受収益')
      }
    ]
  }

  def self.make_invoice
    uri = URI.parse(BASE_URL + '/api/1/invoices')
    http = Net::HTTP.new(uri.host,uri.port)
    http.use_ssl = uri.scheme === "https"
    req = Net::HTTP::Post.new(uri.path)
    req.body = @params.to_json
    req.initialize_http_header(Header.post_header)
    response = http.request(req)
    res_hash = JSON.parse(response.body)
  end
end
