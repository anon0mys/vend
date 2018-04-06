require 'rails_helper'

feature 'When a user visits a snack show page' do
  scenario 'they see the name and price of that snack' do
    snack = Snack.create(name: 'Bag-o-Chips', price: 300)

    visit snack_path(snack)

    expect(page).to have_content(snack.name)
    expect(page).to have_content("Snack Price: $#{snack.price / 100}")
  end

  scenario 'they see a list of locations of machines that have the snack' do
    owner = Owner.create(name: 'Snack Boss')
    machine_one = owner.machines.create(location: 'Some street somewhere')
    machine_two = owner.machines.create(location: 'Some street somewhere else')
    machine_three = owner.machines.create(location: 'A really popular alley')
    snack = Snack.create(name: 'Bag-o-Chips', price: 300)
    Machinesnack.create(machine: machine_one, snack: snack)
    Machinesnack.create(machine: machine_two, snack: snack)
    Machinesnack.create(machine: machine_three, snack: snack)

    visit snack_path(snack)

    expect(page).to have_content(machine_one.location)
    expect(page).to have_content(machine_two.location)
    expect(page).to have_content(machine_three.location)
  end
end
