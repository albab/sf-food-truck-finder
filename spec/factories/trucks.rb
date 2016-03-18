FactoryGirl.define do
  factory :truck do |f|
    f.name "Al's Hotdogs"
    f.lat 37.7721234
    f.lng -122.4052935
    f.food_items 'Hotdogs'
  end

  factory :truck2, class: Truck do |f|
    f.name "Random Truck"
    f.lat 37.7721234
    f.lng -1223.4067935
    f.food_items 'Pizza : BBQ : Hamburgers'
  end

  factory :truck3, class: Truck do |f|
    f.name "Hamburger Truck"
    f.lat 37.7721234
    f.lng -122.3052935
    f.food_items 'Hamburgers'
  end

end