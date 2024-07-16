class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name dob gender role])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end
  def authenticate_user!
    unless request.headers['Authorization'].present?
      render json: { status: {code:"401", message:"Unauthorized Request" }}, status: :unauthorized and return
    end
    jwt_payload = JWT.decode(request.headers['Authorization'].split(" ")[1], Rails.application.credentials.fetch(:device_jwt_secret_key), false)&.first
      @current_user = User.find_by(jti: jwt_payload["jti"])
      unless @current_user.present?
        render json: { status: { code: "401", message: I18n.t('Invalid token')}},status: :unauthorized and return
      end
  end  
end
