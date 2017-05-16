require 'rails_helper'
# giving us access to capybara and other config settings

RSpec.feature "Visitor logins in", type: :feature, js: true do

  before :each do

    @user = User.create!(
      name: "Kevin",
      email: "email@gmail.com",
      password: "password",
      password_confirmation: "password",
    )

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

    visit login_path

  end

  scenario "They click the add button" do

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    click_on 'Submit'

    expect(page).to have_content 'Products'

    save_screenshot 'user-login.png'

  end

end
