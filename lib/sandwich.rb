# frozen_string_literal: true

require_relative 'ingredient'
require_relative 'snack'
class Sandwich < Snack
  @@count ||= 0
  KARADOC_IDEAL_NUMBER_OF_INGREDIENTS = 14

  def initialize(*args)
    @ingredients = []
    raise 'Too many ingredients' if args.size > KARADOC_IDEAL_NUMBER_OF_INGREDIENTS

    args.each do |arg|
      @ingredients << Ingredient.new(arg)
    end
    @@count += 1
  end

  def taste
    "#{['It is', 'Fuc****', 'Heavenly'].sample} delicious#{['.', '!!!!!', ' \o/  !'].sample}"
  end

  attr_reader :ingredients

  def pain_point
    @ingredients.map(&:name).include?('tomatoe') ? 'tomatoes try to slip away on each bite' : false
  end

  def shareable?
    @ingredients.map(&:name).include?('tomatoe') ? 'With difficulty' : 'Yup... why not ?'
  end

  def add_ingredient(ingredient)
    raise 'Please no more ingredient !' if ingredients.size >= KARADOC_IDEAL_NUMBER_OF_INGREDIENTS

    ingredients << ingredient if ingredient.is_a? Ingredient
  end

  def can_be_eaten; end

  def self.count
    @@count
  end
end
