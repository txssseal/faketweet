require 'spec_helper'
describe "Authentication" do
  subject { page }
  describe "signin page" do
    before { visit '/sessions/new' }
    
    describe "with invalid information" do
    	before { click_button "Sign In" }

    	it { should have_title('Sign In') }
    	it { should have_selector('div.alert.alert-error') }

	end

	describe "with valid information" do
		let(:user) { FActoryGirl.create(:user) }
		before do
			fill_in "Email", with: user.email.upcase
			fill_in "Paswword", with: user.password
			click_button "Sign In"
		end

		it { should have_title(user.name) }
		it { should have_link('Profile', href: user_path(user)) }
		it { should have_link('Sign out',    href: signout_path) }
      	it { should_not have_link('Sign in', href: signin_path) }
    end
  end
end

