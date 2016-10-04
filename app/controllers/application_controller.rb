class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def add_instructor
    render :add_instructor
  end
end
