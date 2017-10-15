class ReportController < ApplicationController
  before_action :check_authorization

  def index
    @user_emails = Admin.pluck(:email, :id).to_h
    @card_orders = Tickets.where.not(admin_id: nil).where('updated_at > ?', 30.days.ago)
  end

  def create
    @tickets =
      Admin::TicketStatisticsService
      .new(from: params[:from], to: params[:to], user_id: params[:user_id])
      .call

    render_csv('tickets')
  end

  private

  def check_authorization
    authorize! :manage, Admin.token
  end
end
