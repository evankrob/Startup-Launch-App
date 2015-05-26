# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '166309d30cc5d1e58ec3bfddc6938865'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  private

  def authorize
    #if the user id session is not set, this means the user is not logged on.  Redirect them to the login page.		
    unless session[:user_id]
      flash[:notice] = "Please log in"
      redirect_to(:controller => "Authenticate", :action => "login")
    end
  end



end
