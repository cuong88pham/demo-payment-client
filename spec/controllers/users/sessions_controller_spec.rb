require 'rails_helper'

describe Users::SessionsController, type: :controller do
  let(:user) { create(:user) }

  describe 'POST /users/sign_in', type: :request do
    let(:url) { '/users/sign_in.json' }
    let(:params) do
      {
        user: {
          email: user.email,
          password: 'password'
        }
      }
    end

    context 'when params are correct' do
      before do
        post url, params: params
      end

      it 'returns 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns JTW token in authorization header' do
        expect(response.headers['Authorization']).to be_present
      end
    end

    context 'when login params are incorrect' do
      it 'returns unathorized status' do
        post url

        expect(response.status).to eq 401
      end
    end
  end

  describe 'DELETE /users/sign_out', type: :request do
    let(:url) { '/users/sign_out.json' }

    it 'returns 204, no content' do
      delete url
      expect(response).to have_http_status(204)
    end
  end
end
