require_relative '../key.rb'
require 'date'


GET_HEADER = {
  "accept" => "application/json",
  "Authorization"=> "Bearer #{ACCESS_TOKEN}"
}

POST_HEADER = {
  "accept" => "application/json",
  "Authorization"=> "Bearer #{ACCESS_TOKEN}",
  "Content-Type" => "application/json"
}

INVOICE_PARAMS = {
  "company_id": COMPANY_ID,
  "issue_date": Date.today,
  "due_date": Date.new(Time.now.year, Time.now.month, -1),
  "partner_id": 26435548,
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
      "account_item_id": 400554531
    }
  ]
}


KOUSHIN_PARAMS = {
  "company_id": 2510580,
  "update_date": Date.new(Time.now.year, Time.now.month, -1),
  "renew_target_id": 1682868218,
  "details": [
    {
      "account_item_id": 400554555, #売上高
      "tax_code": 1,
      "amount": 1000,
      "vat": 100
    }
  ]
}
