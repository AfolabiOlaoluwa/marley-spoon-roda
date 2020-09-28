# frozen_string_literal: true

require_relative 'spec_helper'

class Recipe
  describe 'GET /' do
    it 'returns status 200' do
      response = get '/'

      expect(response.status).must_equal 200
    end

    it 'presents titles of recipes' do
      visit '/'

      recipe_titles.each do |homepage_texts|
        assert page.has_text?(homepage_texts)
      end
    end

    it 'presents images of recipes' do
      visit '/'

      assert recipe_images_link_finder.must_equal recipe_image_links
    end

    it 'links to the recipe view page' do
      visit '/'

      assert (recipe_details_link_finder).must_equal recipe_id_links
    end

    private

    def recipe_details_link_finder
      page.find_all('a').map { |link| link['href'] }
    end

    def recipe_images_link_finder
      page.find_all('img').map { |image| image['src'] }
    end

    def recipe_id_links
      %w[
        /
        /4dT8tcb6ukGSIg2YyuGEOm
        /5jy9hcMeEgQ4maKGqIOYW6
        /2E8bc3VcJmA8OgmQsageas
        /437eO3ORCME46i02SeCW46
      ]
    end

    def recipe_titles
      %w[
        White Cheddar Grilled Cheese with Cherry Preserves & Basil
        Tofu Saag Paneer with Buttery Toasted Pita
        Grilled Steak & Vegetables with Cilantro-Jalapeño Dressing
        Crispy Chicken and Rice with Peas & Arugula Salad
      ]
    end

    def recipe_image_links
      %w[
        //images.ctfassets.net/kk2bw5ojx476/61XHcqOBFYAYCGsKugoMYK/0009ec560684b37f7f7abadd66680179/SKU1240_hero-374f8cece3c71f5fcdc939039e00fb96.jpg?w=300&h=200&fm=png&q=100
        //images.ctfassets.net/kk2bw5ojx476/48S44TRZN626y4Wy4CuOmA/9c0a510bc3d18dda9318c6bf49fac327/SKU1498_Hero_154__2_-adb6124909b48c69f869afecb78b6808-2.jpg?w=300&h=200&fm=png&q=100
        //images.ctfassets.net/kk2bw5ojx476/3TJp6aDAcMw6yMiE82Oy0K/2a4cde3c1c7e374166dcce1e900cb3c1/SKU1503_Hero_102__1_-6add52eb4eec83f785974ddeac3316b7.jpg?w=300&h=200&fm=png&q=100
        //images.ctfassets.net/kk2bw5ojx476/5mFyTozvSoyE0Mqseoos86/fb88f4302cfd184492e548cde11a2555/SKU1479_Hero_077-71d8a07ff8e79abcb0e6c0ebf0f3b69c.jpg?w=300&h=200&fm=png&q=100
      ]
    end
  end

  describe 'GET /:id' do
    it 'returns status 200' do
      response = get '/2E8bc3VcJmA8OgmQsageas'

      expect(response.status).must_equal 200
    end

    it 'displays recipe images' do
      visit '/2E8bc3VcJmA8OgmQsageas'

      assert (recipe_image_link_finder).must_equal recipe_image_link
    end

    it 'displays recipe title' do
      visit '/2E8bc3VcJmA8OgmQsageas'

      assert page.has_text? 'Grilled Steak & Vegetables with Cilantro-Jalapeño Dressing'
    end

    it 'displays recipe tags when it has tags' do
      visit '/4dT8tcb6ukGSIg2YyuGEOm'

      assert page.has_selector? 'div#tags/span.btn.btn-primary.btn-sm'
      assert page.has_text? 'vegan'
    end

    it 'does not display recipe tags when it does not have tags' do
      visit '/5jy9hcMeEgQ4maKGqIOYW6'

      assert page.has_no_selector? 'div#tags/span.btn.btn-primary.btn-sm'
    end

    it 'displays recipe details' do
      visit '/437eO3ORCME46i02SeCW46'

      assert page.has_text? recipe_description
    end

    it 'displays recipe chef name when it has a chef' do
      visit '/437eO3ORCME46i02SeCW46'

      assert (page).has_selector?('div#chef')
      assert page.has_text? 'Jony Chives'
    end

    it 'does not display recipe chef name when it does not have a chef' do
      visit '/4dT8tcb6ukGSIg2YyuGEOm'

      assert page.has_no_selector? 'div#chef'
    end

    private

    def recipe_image_link_finder
      page.find('img')['src']
    end

    def recipe_image_link
      '//images.ctfassets.net/kk2bw5ojx476/3TJp6aDAcMw6yMiE82Oy0K/2a4cde3c1c7e374166dcce1e900cb3c1/SKU1503_Hero_102__1_-6add52eb4eec83f785974ddeac3316b7.jpg?w=1020&h=700&fm=png&q=100' # rubocop:disable Layout/LineLength
    end

    def recipe_description
      'Crispy chicken skin, tender meat, and rich, tomatoey sauce form a winning trifecta of delicious ' \
      'in this one-pot braise. We spoon it over rice and peas to soak up every last drop of goodness, and ' \
      'serve a tangy arugula salad alongside for a vibrant boost of flavor and color. Dinner is served! ' \
      'Cook, relax, and enjoy!'
    end
  end
end
