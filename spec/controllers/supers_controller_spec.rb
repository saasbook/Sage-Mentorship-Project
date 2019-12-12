require 'rails_helper'

RSpec.describe SupersController, type: :controller do

  before(:each) do
    @super1 =  Super.find_by(email: 'superspec1@superspec.berkeley.edu') || create(:super, :name => 'rspec1', :email => 'superspec1@superspec.berkeley.edu') # Super.create(name: 'super rspec', email: 'superspec@superspec.berkeley.edu')
    @super2 =  Super.find_by(email: 'superspec2@superspec.berkeley.edu') || create(:super, :name => 'rspec2', :email => 'superspec2@superspec.berkeley.edu') # Super.create(name: 'super rspec', email: 'superspec@superspec.berkeley.edu')
  end
  after(:each) do
    Checkin.delete_all;Checkout.delete_all;Mentor.delete_all;Super.delete_all;Admin.delete_all;School.delete_all
  end

  describe "GET #_index" do
    it "returns http success" do
      get(:_index, session: {:email_address => @super1.email})
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get(:new, session: {:email_address => @super1.email})
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      pp "id = #{@super1.id}, email = #{@super1.email}"
      get :show, params: {id: @super1.id}, session: {id: @super1.id, :email_address => @super1.email}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get(:destroy, params: {id: @super2.id}, session: {id: @super1.id, :email_address => @super1.email})
      expect(response).to have_http_status(:redirect)
    end
  end

end
