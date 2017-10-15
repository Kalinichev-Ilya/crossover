require 'rails_helper'

describe TicketStatisticsService do
  subject(:metrics) do
    described_class.new(from: from, to: to, user_id: user.id)
  end

  let(:from) { 1.month.ago.to_s }
  let(:to) { Date.today.to_s }
  let(:user) { create(:admin) }
  let!(:ticket) { create(:ticket, :completed, admin_id: user.id) }

  describe '.call' do
    it 'returns array with ticket' do
      expect(subject.call.first).to eq(ticket)
    end
  end
end
