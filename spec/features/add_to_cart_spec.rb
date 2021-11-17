require 'rails_helper'

RSpec.feature "User clicks the add to cart button", type: :feature, js: true do

  # Setup
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
  end

  scenario "The cart content counter is incremented" do

    visit root_path

    expect(page).to have_content('My Cart (0)')

    find('.product button.btn-primary', match: :first).click

    expect(page).to have_content('My Cart (1)')
  end

end
