require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "Profile Page" do
    let(:user) { FactoryGirl.create(:user) } 
    before { visit user_path(user)} 

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "Signup Page" do
    before {visit signup_path}

    it { should have_content('Sign Up')}
    it { should have_title(full_title('Sign Up'))}
  end

  describe "Edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "Page" do
      it { should have_content("Update Your Profile") }
      it { should have_title("Edit User") }
      it { should have_link('Change', href: 'http://gravatar.com/emails') }
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }

      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
	click_button "Save Changes"
      end

      it { should have_title(new_name)}
      it { should have_selector('div.alert.alert-success')}
      it { should have_link('Sign Out', href: signout_path)}
      specify { expect(user.reload.name).to eq new_name}
      specify { expect(user.reload.email).to eq new_email}
    end

    describe "with invalid information" do
      before { click_button "Save Changes" }

      it { should have_content('error') }
    end
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create My Account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign Up')} 
        it { should have_content('error')} 
      end
    end


    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      describe "after saving the user" do
        before { click_button submit }
	let(:user) { User.find_by(email: "user@example.com") }

	it { should have_title(user.name) }
	it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
	let(:user) { User.find_by(email: 'user@example.com') }

	it { should have_link('Sign Out') }
	it { should have_title(user.name) }
	it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end
end
