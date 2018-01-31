class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cache_key

  def session_cache_key
    session[:time_of_first_visit]
  end
  helper_method :session_cache_key

  private

  def set_cache_key
    session[:time_of_first_visit] ||= Time.zone.now
  end
end
