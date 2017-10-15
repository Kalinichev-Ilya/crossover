class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  def render_csv(filename = nil, csv_options = { col_sep: ';' })
    @filename = "#{filename || controller_name}.csv"
    @csv_options = csv_options
  
    render layout: false
  end
  
  private
  
  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
