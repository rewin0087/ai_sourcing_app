class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def current_candidate
    @current_candidate ||= current_user.candidate
  end

  def require_candidate!
    return if current_user&.candidate?
    render json: { error: "Access denied. Candidate role required." }, status: :forbidden
  end

  def require_sourcer!
    return if current_user&.sourcer? || current_user&.admin?
    render json: { error: "Access denied. Sourcer role required." }, status: :forbidden
  end

  def render_success(data, status: :ok)
    render json: { success: true, data: data }, status: status
  end

  def render_error(message, status: :unprocessable_entity, errors: nil)
    payload = { success: false, error: message }
    payload[:errors] = errors if errors
    render json: payload, status: status
  end
end
