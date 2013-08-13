require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
    it "should have the content 'Microblog'" do
      visit root_path
      expect(page).to have_content('Microblog')
    end
    it "should have the right title 'Home'" do
      visit root_path
      expect(page).to have_title('Ruby On Rails Tutorial Microblog')
    end
    it "should not have a custom page title title 'Home'" do
      visit root_path
      expect(page).not_to have_title('| Home')
    end
  end

  describe "Help Page" do
    it "should have the content 'Help'" do
      visit help_path
      expect(page).to have_content('Help')
    end
    it "should have the right title 'Help'" do
      visit help_path
      expect(page).to have_title('Ruby On Rails Tutorial Microblog | Help')
    end
  end

  describe "About Page" do
    it "should have the content 'About Us'" do
      visit about_path
      expect(page).to have_content('About Us')
    end
    it "should have the right title 'About'" do
      visit about_path
      expect(page).to have_title('Ruby On Rails Tutorial Microblog | About')
    end
  end

  describe "Contact Page" do
    it "should have the content 'Contact Us'" do
      visit contact_path
      expect(page).to have_content('Contact Us')
    end
    it "should have the right title 'Contact'" do
      visit contact_path
      expect(page).to have_title('Ruby On Rails Tutorial Microblog | Contact')
    end
  end
end
