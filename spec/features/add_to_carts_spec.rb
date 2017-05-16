require 'rails_helper'
# giving us access to capybara and other config settings

RSpec.feature "Visitor adds an item to cart", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end

    visit root_path

  end

  scenario "They click the add button" do

    first('.btn-primary').click

    within '.navbar' do
      expect(page).to have_content 'My Cart (1)'
    end
    # DEBUG / VERIFY
    save_screenshot 'add-to-cart.png'

  end

end
