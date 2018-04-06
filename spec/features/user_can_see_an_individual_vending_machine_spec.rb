require 'rails_helper'

feature 'When a user visits a vending machine show page' do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  scenario 'they see the snacks that are available in the machine' do
    owner = Owner.create(name: 'Snack Boss')
    machine = owner.machines.create(location: 'Some street somewhere')
    snack_one = machine.snacks.create(name: 'Bag-o-Chips', price: 300)
    snack_two = machine.snacks.create(name: 'Cand E Bar', price: 200)
    snack_three = machine.snacks.create(name: 'Soda', price: 400)

    visit machine_path(machine)

    expect(page).to have_content(snack_one.name)
    expect(page).to have_content("$#{snack_two.price / 100}")
    expect(page).to have_content(snack_three.name)
  end

  scenario 'they see the average price of snacks in the machine' do
    owner = Owner.create(name: 'Snack Boss')
    machine = owner.machines.create(location: 'Some street somewhere')
    machine.snacks.create(name: 'Bag-o-Chips', price: 300)
    machine.snacks.create(name: 'Cand E Bar', price: 200)
    machine.snacks.create(name: 'Soda', price: 400)

    visit machine_path(machine)

    expect(page).to have_content('Average Price: $3.00')
  end

  scenario 'they see a different average price of snacks' do
    owner = Owner.create(name: 'Snack Boss')
    machine = owner.machines.create(location: 'Some street somewhere')
    machine.snacks.create(name: 'Bag-o-Chips', price: 300)
    machine.snacks.create(name: 'Cand E Bar', price: 200)
    machine.snacks.create(name: 'Soda', price: 400)
    machine.snacks.create(name: 'Soda', price: 900)

    visit machine_path(machine)

    expect(page).to have_content('Average Price: $4.50')
  end
end
