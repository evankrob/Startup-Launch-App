class AuthenticateController < ApplicationController

  layout "main"


  def index
    if session[:user_id]>0
      redirect_to :controller => 'Users', :action=> 'index'
    else
      redirect_to :action=> 'login'
    end
  end
 


  def login
    if params[:userform]

      #find records with username,password
      #if statement checks whether valid_user exists or not

      if (params[:userform][:username].eql? "TheBoss") && (params[:userform][:password].eql? "dfsf0323j4h3")
        #creates a session with username
        session[:user_id]=1
        #redirects the user to our private page.
        redirect_to :controller=>"users", :action => 'index'
      else
        flash[:notice] = "Invalid User/Password"
      end
    end
  end



  def logout
    if session[:user_id]
      reset_session
    end
      redirect_to :action=> 'login'
  end


end
