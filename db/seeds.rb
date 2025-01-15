Product.create!([
  {
    name: 'Crampons',
    price: 74.99
  },
  {
    name: 'Ice axe',
    price: 84.99
  },
  {
    name: 'Helmet',
    price: 69.99
  },
  {
    name: 'Rope',
    price: 15.99
  },
  {
    name: 'Climbing shoes',
    price: 79.99
  },
  {
    name: 'Backpack',
    price: 99.99
  },
  {
    name: 'Chalk',
    price: 9.99
  },
  {
    name: 'Boots',
    price: 94.99
  },
  {
    name: 'Jacket',
    price: 149.99
  },
  {
    name: 'Pants',
    price: 99.99
  },
  {
    name: 'Therm-A-Rest',
    price: 79.99
  },
  {
    name: 'Tent',
    price: 199.99
  }
])

[
  [ "Crampons", "crampons.jpg" ],
  [ "Ice axe", "iceaxe.jpg" ],
  [ "Helmet", "helmet.jpg" ],
  [ "Rope", "rope.jpg" ],
  [ "Climbing shoes", "shoes.jpg" ],
  [ "Backpack", "backpack.jpg" ],
  [ "Chalk", "chalk.jpg" ],
  [ "Boots", "boots.jpg" ],
  [ "Jacket", "jacket.jpeg" ],
  [ "Pants", "pants.jpg" ],
  [ "Therm-A-Rest", "therm.jpg" ],
  [ "Tent", "tent.jpg" ]
].each do |product_name, file_name|
  product = Product.find_by!(name: product_name)
  file = File.open(Rails.root.join("app/assets/images/#{file_name}"))
  product.main_image.attach(io: file, filename: file_name)
end
