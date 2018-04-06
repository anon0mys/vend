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

  scenario 'they see each location\'s snack count and average_price' do
    owner = Owner.create(name: 'Snack Boss')
    machine_one = owner.machines.create(location: 'Some street somewhere')
    machine_two = owner.machines.create(location: 'Some street somewhere else')
    machine_three = owner.machines.create(location: 'A really popular alley')
    snack_one = Snack.create(name: 'Bag-o-Chips', price: 300)
    snack_two = Snack.create(name: 'Cand E Bar', price: 200)
    snack_three = Snack.create(name: 'Soda', price: 500)
    Machinesnack.create(machine: machine_one, snack: snack_one)
    Machinesnack.create(machine: machine_two, snack: snack_one)
    Machinesnack.create(machine: machine_three, snack: snack_one)
    Machinesnack.create(machine: machine_three, snack: snack_two)
    Machinesnack.create(machine: machine_three, snack: snack_three)

    visit snack_path(snack_one)

    within 'li:first-child' do
      expect(page).to have_content("1 kinds of snacks, average price of $3.00")
    end

    within 'li:last-child' do
      expect(page).to have_content("3 kinds of snacks, average price of $3.33")
    end
  end
end
