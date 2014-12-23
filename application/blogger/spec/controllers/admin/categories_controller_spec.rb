require 'rails_helper'

RSpec.describe Admin::CategoriesController, :type => :controller do

  describe "Visit actions success when logged in" do
    login_user

    it "returns http success visit index with GET method" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns http success visit new with GET method" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "returns http success visit edit with GET method" do
      category = Category.create(name: :Animals)
      get :edit, { id: category.id }
      expect(response).to have_http_status(:success)
    end

    it "returns http success visit destroy with DELETE method" do
      category = Category.create(name: :Animals)
      delete :destroy, { id: category.id }
      # will redirect to index
      expect(response).to have_http_status(302)
    end
  end

  describe "Visit actions will redirect when not logged in" do
    it "returns redirect when visit index with GET method" do
      get :index
      expect(response).to have_http_status(302)
    end

    it "returns redirect when visit new with GET method" do
      get :new
      expect(response).to have_http_status(302)
    end

    it "returns redirect when visit edit with GET method" do
      category = Category.create(name: :Animals)
      get :edit, { id: category.id }
      expect(response).to have_http_status(302)
    end

    it "returns redirect when visit destroy with DELETE method" do
      category = Category.create(name: :Animals)
      delete :destroy, { id: category.id }
      # will redirect to index
      expect(response).to have_http_status(302)
    end
  end
end
