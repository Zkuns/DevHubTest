require 'rails_helper'

RSpec.describe CombosController, type: :controller do
  let(:combo) { create(:combo) }
  login_user

  describe 'Get Index' do
    it 'return 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'Get Show' do
    it 'return 200' do
      get :show, params: { id: combo.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'Get Subscribe' do
    it 'return 200' do
      expect { get :subscribe, params: { id: combo.id } }.to change { Subscription.count }.by(1)
      expect(response).to redirect_to(combos_path)
    end
  end
end
