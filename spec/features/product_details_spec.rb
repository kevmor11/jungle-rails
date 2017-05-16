require 'rails_helper'
# giving us access to capybara and other config settings

RSpec.feature "Visitor clicks a product description", type: :feature, js: true do

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

  scenario "They click onto product page" do

    first('.pull-right').click

    expect(page).to have_content 'Reviews'
    # DEBUG / VERIFY
    save_screenshot 'item-page.png'


  end

end
