require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:customer) { Customer.create(name: Faker::Superhero.name,
                                   email: Faker::Internet.email,
                                   password: Faker::Internet.password) }
  # test 'should get index' do
  describe 'GET index' do
    it 'have 200 status' do
      request.headers[:Authorization] = customer.token
      get :index
      expect(response.status).to eq(200)
    end

    it 'assigns @comments' do
      request.headers[:Authorization] = customer.token
      comment = Comment.create
      get :index
      expect(assigns(:comments)).to eq([comment])
    end
  end

  # test 'should create comment' do

  # test 'should show comment' do

  # test 'should update comment' do

  # test 'should destroy comment' do
end
