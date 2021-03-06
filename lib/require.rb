require 'date'

require './invoice/invoice.rb'
require './koushin/koushin.rb'
require './torihiki/torihiki.rb'
require './account_items/account_items.rb'
require './company/company.rb'
require './supplier/supplier.rb'
require './helper.rb'

#don`t touch!!
month = Time.now.month
year = Time.now.year
count = 1

#請求書総額(外税)
amount = 12900321
#消費税額
vat = 129003
#+更新回数
num = 12

# 請求書のパラメーター
invoice_params = {
  "company_id": Company.company_id,
  "issue_date": Date.today,
  "due_date": Date.new(year, month, -1),
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
      "unit_price": amount,
      "vat": vat,
      "description": "備考",
      "tax_code": 2,
      "account_item_id": AccountItem.account_item_id('前受収益') #この請求書に紐づく取引の勘定科目は前受収益
    }
  ]
}

#請求書の発行
invoice = Invoice.make_invoice(invoice_params)
#請求書発行のレスポンスから取引idを取得
torihiki_id = invoice['invoice']['deal_id']
#上記取引idの取引行idを取得
renew_target_id = Torihiki.target_id(torihiki_id)

#取引id 取引行idを使ってプラス更新をかける
num.times do
  #初回のプラス更新額を計算
  if count == 1
    koushin_amount = first_price(amount,num)
    koushin_vat = first_price(vat,num)
  else
    koushin_amount = amount / num
    koushin_vat = vat / num
  end

  date = Date.new(year, month, -1)
  koushin_params = {
    "company_id": Company.company_id,
    "update_date": date,
    "renew_target_id": renew_target_id,
    "details": [
      {
        "account_item_id": AccountItem.account_item_id('売上高'),#プラス更新の勘定科目は売上高
        "tax_code": 21,
        "amount": (koushin_amount + koushin_vat),
        "vat": koushin_vat
      }
    ]
  }
  puts Koushin.post_koushin(torihiki_id,koushin_params)
  # 翌月の年月を取得
  month = add_month(month)
  year += 1 if month == 1
  count += 1
end
