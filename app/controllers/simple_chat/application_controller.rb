module SimpleChat
  class ApplicationController < ActionController::Base
    before_filter :verify_valid_user?


    def current_user
      return unless session[:id]
      verify_valid_user?
      @current_user ||= User.find(session[:id])
    end

    protected
    def verify_valid_user?
      session[:id] = nil unless User.exists? session[:id]
      return true if session[:id] && session[:name]
      user = User.find(cookies['user_id']) if cookies['user_id'] && User.exists?(cookies['user_id'])
      user ||= User.create!
      load_attributes(user.id)
      return false
    end

    private
    def load_attributes(id)
      session.merge! User.load_attributes(id, %w[id name])
      cookies['user_id'] = session[:id]
    end
  end


end
