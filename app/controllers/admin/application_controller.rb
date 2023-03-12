# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
class Admin::ApplicationController < Administrate::ApplicationController
  class AuthorizationError < StandardError
  end

  before_action :authenticate_user!
  before_action :set_current_user

  rescue_from AuthorizationError, with: :render_422
  # Override this value to specify the number of elements to display at a time
  # on index pages. Defaults to 20.
  # def records_per_page
  #   params[:per_page] || 20
  # end

  def set_current_user
    @current_user ||= current_user
  end

  def render_422
    render file: "#{Rails.root}/public/422.html", status: :not_found
  end
end
