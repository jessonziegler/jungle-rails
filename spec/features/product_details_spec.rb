require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

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

  scenario "They see the product details" do

    visit root_path

    expect(page).to have_no_css('.product-detail')

    find('.product a.btn-default', match: :first).click

    expect(page).to have_css('.product-detail')
  end
end