require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
    it "should have the content 'Microblog'" do
      visit '/static_pages/home'
      expect(page).to have_content('Microblog')
    end
    it "should have the right title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title('Ruby On Rails Tutorial Microblog | Home')
    end
  end

  describe "Help Page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
    it "should have the right title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title('Ruby On Rails Tutorial Microblog | Help')
    end
  end

  describe "About Page" do
    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end
    it "should have the right title 'About'" do
      visit '/static_pages/about'
      expect(page).to have_title('Ruby On Rails Tutorial Microblog | About')
    end
  end
end
