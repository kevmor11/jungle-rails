require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      @category = Category.create! name: 'Apparel'

      @user = User.create!(
        name: "Kevin",
        email: "email@gmail.com",
        password: "password",
        password_confirmation: "password",
      )

      @product1 = Product.create!(
        name:  'Product 1',
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 50,
        category: @category
      )
      @product2 = Product.create!(
        name:  'Product 2',
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel2.jpg'),
        quantity: 10,
        price: 50,
        category: @category
      )
      @product3 = Product.create!(
        name:  'Product 3',
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel3.jpg'),
        quantity: 10,
        price: 50,
        category: @category
      )

      @order = Order.new(
        email: @user.email,
        total_cents: 15000,
        stripe_charge_id: 1
      )
      # 2. build line items on @order
      @item1 = @order.line_items.new(
        product: @product3,
        quantity: 1,
        item_price: 50,
        total_price: 50
      )
      @item2 = @order.line_items.new(
        product: @product2,
        quantity: 2,
        item_price: 50,
        total_price: 100
      )
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product3.reload
      @product2.reload
      # Setup at least one product that will NOT be in the order
    end
    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      # 5. use RSpec expect syntax to assert their new quantity values
      # ...
      expect(@product3.quantity).to eq 9
      expect(@product2.quantity).to eq 8
    end
    # pending test 2
    it 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints in previous test
      expect(@product1.quantity).to eq 10
    end
  end
end
