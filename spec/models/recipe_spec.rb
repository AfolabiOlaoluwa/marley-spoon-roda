# frozen_string_literal: true

require_relative 'spec_helper'

class Recipe
  describe '.all_recipes' do
    RECIPES_IDS = %w[4dT8tcb6ukGSIg2YyuGEOm 5jy9hcMeEgQ4maKGqIOYW6 2E8bc3VcJmA8OgmQsageas 437eO3ORCME46i02SeCW46].freeze
    IMAGES_IDS = %w[61XHcqOBFYAYCGsKugoMYK 48S44TRZN626y4Wy4CuOmA 3TJp6aDAcMw6yMiE82Oy0K 5mFyTozvSoyE0Mqseoos86].freeze
    IMAGE_URLS = %w[//images.ctfassets.net/kk2bw5ojx476/61XHcqOBFYAYCGsKugoMYK/0009ec560684b37f7f7abadd66680179/SKU1240_hero-374f8cece3c71f5fcdc939039e00fb96.jpg //images.ctfassets.net/kk2bw5ojx476/48S44TRZN626y4Wy4CuOmA/9c0a510bc3d18dda9318c6bf49fac327/SKU1498_Hero_154__2_-adb6124909b48c69f869afecb78b6808-2.jpg //images.ctfassets.net/kk2bw5ojx476/3TJp6aDAcMw6yMiE82Oy0K/2a4cde3c1c7e374166dcce1e900cb3c1/SKU1503_Hero_102__1_-6add52eb4eec83f785974ddeac3316b7.jpg //images.ctfassets.net/kk2bw5ojx476/5mFyTozvSoyE0Mqseoos86/fb88f4302cfd184492e548cde11a2555/SKU1479_Hero_077-71d8a07ff8e79abcb0e6c0ebf0f3b69c.jpg].freeze # rubocop:disable Layout/LineLength

    it 'return all necessary records with content type recipe' do
      recipes = Recipe.all_recipes
      assert !recipes.nil?
      expect(recipes).must_be_instance_of Contentful::Array
      expect(recipes.map(&:id)).must_equal RECIPES_IDS
      expect(recipes.map(&:title).first).must_match('White Cheddar Grilled Cheese with Cherry Preserves & Basil')
      expect(recipes.map { |o| o.photo.id }).must_equal IMAGES_IDS
      expect(recipes.map { |o| o.photo.url }).must_equal IMAGE_URLS
    end
  end

  describe '.find_recipe' do
    SINGLE_RECIPE_IMAGE_TAGS = %w[vegan].freeze
    SINGLE_RECIPE_IMAGE_URL = '//images.ctfassets.net/kk2bw5ojx476/61XHcqOBFYAYCGsKugoMYK/0009ec560684b37f7f7abadd66680179/SKU1240_hero-374f8cece3c71f5fcdc939039e00fb96.jpg' # rubocop:disable Layout/LineLength

    it 'returns a certain record' do
      single_recipe = Recipe.find_recipe('4dT8tcb6ukGSIg2YyuGEOm')

      expect(single_recipe.title).must_match('White Cheddar Grilled Cheese with Cherry Preserves & Basil')
      expect(single_recipe.photo.id).must_equal '61XHcqOBFYAYCGsKugoMYK'
      expect(single_recipe.photo.url).must_equal SINGLE_RECIPE_IMAGE_URL
      expect(single_recipe.description).wont_be_nil
      expect(single_recipe.tags.map(&:name)).must_equal SINGLE_RECIPE_IMAGE_TAGS
      expect(single_recipe.chef).must_be_nil
    end

    it 'returns nil when record does not exist' do
      unknown_recipe = Recipe.find_recipe('4dT8tcb6')
      assert unknown_recipe.must_be_nil
    end

    it 'returns nil when a record has no tag-name associated with it' do
      single_recipe = Recipe.find_recipe('5jy9hcMeEgQ4maKGqIOYW6')

      expect(single_recipe.tags).must_be_nil
    end

    it 'returns chef name when record has a chef name listed' do
      single_recipe = Recipe.find_recipe('2E8bc3VcJmA8OgmQsageas')
      expect(single_recipe.chef.name).must_match('Mark Zucchiniberg')
    end
  end
end
