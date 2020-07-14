#月の処理
def add_month(num)
  if num < 12
    return num = num + 1
  elsif num == 12
    num = 1
  end
end
# 初月のプラス更新額を求める処理
def first_price(price,times)
  (price % times) + (price / times)
end
