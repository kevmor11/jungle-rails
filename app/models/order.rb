class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  def total_order_price
    line_items.sum(:total_price_cents)
  end

  def cart_is_empty
    if cart.size > 0
    end
  end

end
