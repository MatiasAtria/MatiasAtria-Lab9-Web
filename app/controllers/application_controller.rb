class ApplicationController < ActionController::Base
  include Pundit::Authorization

  allow_browser versions: :modern
  stale_when_importmap_changes

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, if: :pundit_authorization_required?
  after_action :verify_policy_scoped, if: :pundit_policy_scoped_required?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back_or_to(root_path)
  end

  def pundit_authorization_required?
    !skip_pundit? && !index_action?
  end

  def pundit_policy_scoped_required?
    !skip_pundit? && index_action?
  end

  def skip_pundit?
    devise_controller? || params[:controller] == "pages"
  end

  def index_action?
    action_name == "index"
  end
end