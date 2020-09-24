require 'contentful_model'

class Recipe < ContentfulModel::Base
  self.content_type_id = 'recipe'

  def self.all_recipes
    all.load!
  end
end