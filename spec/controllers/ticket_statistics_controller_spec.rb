require 'rails_helper'

RSpec.describe TicketStatisticsController do
  describe 'GET index' do
    let!(:ticket) { create(:ticket, :processing) }

    it 'responds with 200 :success' do
      subject { get :index }

      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH decline_issue' do
    subject { patch :decline_issue, ticket_id: ticket.reload.uuid }

    let!(:ticket) { create(:ticket, :processing) }

    it 'sets admin user to ticket' do
      subject
      ticket.reload

      expect(ticket.admin_id).to eq(current_user.id)
      expect(ticket).to be_cancelled
      expect(response).to have_http_status(:redirect)
    end
  end
end
