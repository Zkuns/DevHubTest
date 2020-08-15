# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Combo.create(name: 'combo 1', price: 10.99, description: 'tasty delicious1', cut_off_week: 2, cut_off_time: '18:00:00')
Combo.create(name: 'combo 2', price: 19.99, description: 'tasty delicious2', cut_off_week: 3, cut_off_time: '06:00:00')
Combo.create(name: 'combo 3', price: 12.99, description: 'tasty delicious3', cut_off_week: 4, cut_off_time: '20:00:00')
Combo.create(name: 'combo 4', price: 15.99, description: 'tasty delicious4', cut_off_week: 5, cut_off_time: '12:00:00')
Combo.create(name: 'combo 5', price: 16.99, description: 'tasty delicious5', cut_off_week: 6, cut_off_time: '12:00:00')

Combo.all.each do |combo|
  OrderGroup.create(combo_id: combo.id, start_at: combo.current_cut_off_time)
end
