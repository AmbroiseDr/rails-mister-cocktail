# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'JSON'

Cocktail.destroy_all
Dose.destroy_all
Ingredient.destroy_all

puts 'Fetching ingredients'
url_ingredients = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

ingredients = JSON.parse(open(url_ingredients).read)["drinks"]

ingredients.each do |ingredient|
  Ingredient.create(name: ingredient["strIngredient1"])
end

puts 'Finished for ingredients'

puts 'Fetching cocktails'

('a'..'z').each do |letter|
  url_cocktails = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=#{letter}"
  cocktails = JSON.parse(open(url_cocktails).read)["drinks"]
  unless cocktails.nil?
    cocktails.each do |cocktail|
      puts "Creation of cocktail"
      c = Cocktail.create(name: cocktail["strDrink"], url: cocktail["strDrinkThumb"], description: cocktail["strInstructions"])
      puts "Cocktail created"
      puts "==============="
      (1..15).each do |element|
      puts "Creation dose #{element} for #{cocktail["strDrink"]}"
        unless ( cocktail["strIngredient#{element}"].nil? || cocktail["strIngredient#{element}"] == "")
          Ingredient.create(name: cocktail["strIngredient#{element}"]) if ((Ingredient.find_by name: cocktail["strIngredient#{element}"]).nil? || (Ingredient.find_by name: cocktail["strIngredient#{element}"]) == "")
          ingredient1 = Ingredient.find_by name: cocktail["strIngredient#{element}"]
          description = cocktail["strMeasure#{element}"]
          description = "Fill the glass" if (cocktail["strMeasure#{element}"].nil? || cocktail["strMeasure#{element}"] == "\n" || cocktail["strMeasure#{element}"] == "")
          puts description
          d1 = Dose.new(description: description)
          d1.cocktail = c
          d1.ingredient = ingredient1
          d1.order = element
          d1.save!
        end
      puts "Dose #{element} created"
      puts "==============="
      end
    end
  end
 end

puts 'Finish for cocktails'
