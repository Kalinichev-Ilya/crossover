module Admin
  class TicketStatisticsService
    def initialize(from:, to:, user_id: nil)
      @from = from.present? ? Date.parse(from) : 1.week.ago
      @to = to.present? ? Date.parse(to) : Date.tomorrow
      @user_id = Admin.exists?(id: user_id) && user_id
    end

    def call
      tickets = Tickets.completed.where('date(updated_at) >= :from AND date(updated_at) <= :to', from: from, to: to)
      tickets = tickets.where(admin_id: user_id) if user_id
      tickets.reorder(admin_id: :desc, updated_at: :desc)
    end

    private

    attr_reader :from, :to, :user_id
  end
end
