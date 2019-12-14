require 'rails_helper'

RSpec.describe LoginsController, type: :controller do
  before(:each) do
    @super1 =  Super.find_by(email: 'superspec1@superspec.berkeley.edu') || create(:super, :name => 'rspec1', :email => 'superspec1@superspec.berkeley.edu')
  end

  after(:each) do
    Checkin.delete_all;Checkout.delete_all;Mentor.delete_all;Super.delete_all;Admin.delete_all;School.delete_all
  end

  let(:valid_session) { {:user_id => 1, :id => 1, :email_address => @super1.email} }

  describe "GET #destroy" do
    it "redirects to root" do
      get :destroy, params: {}, session: valid_session
      expect(session[:user_id]).to be(nil)
      expect(session[:email_address]).to be(nil)
      expect(session[:id]).to be(nil)
      expect(response).to redirect_to(:root)
    end
  end

end
