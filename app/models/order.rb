class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_save :update_quantity

  def total_order_price
    line_items.sum(:total_price_cents)
  end

  def cart_is_empty
    if cart.size > 0
    end
  end

  private

  def update_quantity
    self.line_items.all.each do |item|
      product = Product.find(item.product_id)
      product.quantity = product.quantity - item.quantity
      product.save!
    end
  end

end
