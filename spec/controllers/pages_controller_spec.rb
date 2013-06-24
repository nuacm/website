require 'spec_helper'

describe PagesController do
  describe "GET #home" do
    it "responds successfully with an HTTP 200 status code" do
      get :home
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the home template" do
      get :home
      expect(response).to render_template("home")
    end
  end

  describe "GET #about" do
    it "responds successfully with an HTTP 200 status code" do
      get :about
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the about template" do
      get :about
      expect(response).to render_template("about")
    end
  end

  describe "GET #playground" do
    it "responds successfully with an HTTP 200 status code" do
      get :playground
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the playground template" do
      get :playground
      expect(response).to render_template("playground")
    end
  end
end
