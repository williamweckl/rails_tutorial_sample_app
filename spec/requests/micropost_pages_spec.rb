require 'rails_helper'

describe "MicropostPages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do

    before { visit root_path }

    describe "with invalid information" do
      it "should not create a micropost" do
        expect
      end
    end

    it "works! (now write some real specs)" do
      get micropost_pages_index_path
      expect(response.status).to be(200)
    end
  end
end
