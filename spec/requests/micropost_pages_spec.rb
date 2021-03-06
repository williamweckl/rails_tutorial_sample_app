require 'rails_helper'

describe "MicropostPages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do

    before { visit root_path }

    describe "with invalid information" do
      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end

    end
  end

  describe "micropost destruction" do

    describe "as correct user" do
      before do
        FactoryGirl.create(:micropost, user: user)
        visit root_path
      end

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end

    describe "as incorrect user" do
      let!(:another_user_micropost) { FactoryGirl.create(:micropost, user: FactoryGirl.create(:user)) }

      before { sign_in user, :no_capybara => true }

      it "should not delete a micropost" do
        expect { delete micropost_path(another_user_micropost) }.to_not change(Micropost, :count)
      end
    end
  end

end
