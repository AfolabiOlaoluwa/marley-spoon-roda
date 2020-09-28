# frozen_string_literal: true

require 'contentful_model'
class Recipe < ContentfulModel::Base
  self.content_type_id = 'recipe'
  def self.all_recipes
    all.load!
  end

  def self.find_recipe(id)
    find(id)
  end
end
