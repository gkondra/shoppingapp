#product_category books,food, and medical products

class Product

  IMPORT_TAX = 5.0
  SALES_TAX = 10.0
  CENTS_ROUNDING_MULTIPLIER = 20.0

@@taxFreeProducts = ["book", "chocolate bar", "packet of headache pills", "box of imported chocolates", "imported box of chocolates"]
attr_accessor :product_name

def initialize(name, price)
  @product_name=name
#  @product_category="category"
  @product_price=price
#  @isImported_product="isImported"
  @taxrate=@@taxFreeProducts.include?(@product_name) ? 0.0 : (SALES_TAX/100)
  @taxrate=@taxrate + (@product_name.include?("imported") ? (IMPORT_TAX/100) : 0.0)
end

def getPrice(qty)
amount = qty * @product_price
tax_amount = amount * @taxrate
amount=amount + tax_amount
return amount, round_amount(tax_amount)
end

def round_amount(amount)
    ((amount * 20).round.to_f / CENTS_ROUNDING_MULTIPLIER).round(3)
  end

end

PurchaseItem = Struct.new( :product, :qty )

class Basket

def initialize ()
  @productlist=Array.new
end

def product_parse(prod = items)
prod.each do |i|
product, rate, qty = addProductPurchase(i)
@productlist<<PurchaseItem.new(Product.new( product, rate),qty)
end
end


 def addProductPurchase(i)
  puts i
   s = i.split
  qty = s[0].to_i
  rate = s[-1].to_f
  product = input.split(" at ")[0].delete("/0-9/").strip
  return product,rate,qty 
  end


def printReceipt
totalamount=0.0
salestax=0.0
@productlist.each do |i|
  amount,tax= i.product.getPrice(i.qty)
  puts i.qty.to_s + i.product.product_name + ": " + amount.round(2).to_s
  totalamount=totalamount+amount.round(2)
  salestax=salestax+tax
end

puts "Sales Taxes: " + salestax.round(2).to_s
puts "Total: " + totalamount.round(2).to_s

end

def items
return p = File.open("./items.txt").readlines
end
end

b=Basket.new
b.addProductPurchase(@p1)
b.addProductPurchase(@p2)
b.addProductPurchase(@p3)


b.printReceipt()
