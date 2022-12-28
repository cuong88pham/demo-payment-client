require 'rails_helper'

describe Users::RegistrationsController, type: :controller do
  describe 'POST /users', type: :request do
    let(:url) { '/users' }
    let(:params) do
      {
        user: {
          email: 'user@example.com',
          password: 'password'
        }
      }
    end
    let(:json) { JSON.parse(response.body) }

    context 'when user is unauthenticated' do
      before do
        post url, params: params
      end

      it 'returns 200' do
        expect(response.status).to eq 200
      end

      it 'returns a new user' do
        expect(response.body['user']).to be_present
      end
    end

    context 'when user already exists' do
      let!(:user) { create(:user, email: params[:user][:email]) }

      before do
        post url, params: params
      end

      it 'returns bad request status' do
        expect(response.status).to eq 400
      end

      it 'returns validation errors' do
        expect(json['errors'].first['title']).to eq('Bad Request')
      end
    end
  end
end
