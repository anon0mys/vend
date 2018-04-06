require 'rails_helper'

feature 'When a user visits a snack show page' do
  scenario 'they see the name and price of that snack' do
    snack = Snack.create(name: 'Bag-o-Chips', price: 300)

    visit snack_path(snack)

    expect(page).to have_content(snack.name)
    expect(page).to have_content("Snack Price: $#{snack.price / 100}")
  end
end
