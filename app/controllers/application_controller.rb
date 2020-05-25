class ApplicationController < ActionController::Base
    protect_from_forgery prepend: true
    include SessionsHelper
    def current_user  
        return unless session[:user_id]  
        @current_user ||= User.find(session[:user_id])  
    end
    
    def logged_in_user
        unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
        end
        end
end
