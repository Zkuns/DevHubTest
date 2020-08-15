require 'rails_helper'

RSpec.describe OrderGroupsController, type: :controller do
  let(:order_group) { create(:order_group) }

  login_user

  describe 'Get Show' do
    it 'return 200' do
      get :show, params: { id: order_group.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
