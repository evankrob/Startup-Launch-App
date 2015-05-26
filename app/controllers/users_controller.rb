class UsersController < ApplicationController

 before_filter :authorize
 skip_before_filter :authorize, :only => [:new, :success, :create]

 layout 'main'

  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new



    #if a referral code is set, let's check to make sure it is valid, otherwise, get rid of it.
    result_count= User.find(:all, :conditions  => ["referral_code = ?", params[:id] ] ).length
    
    if result_count != 1
      unless params[:id].nil?
        redirect_to :action => 'new',:controller => 'users', :id=>''
      end
    end

    @user = User.new

  end


  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    #Generate random, unique referral code

	#check to see if the email address has already been entered
	user_to_check=User.find_by_email(params[:user][:email])
	if !user_to_check.nil?
		redirect_to :action => 'success', :id=>user_to_check.referral_code
	else
	
	
		referral_unique=0    

		while referral_unique==0
		  #generate a new code that is six digits
		  good_random_number=0  #set the variable for the loop
		  while good_random_number==0
			#generate the random number- It may be less than six digits!!
			new_referral_code = rand(1000000)
			#make sure referral code is six (6) digits
			if new_referral_code.to_s.length == 6
			  good_random_number= 1
			end
		  end

		  #make sure referral code is unique
		  if User.find_by_referral_code(new_referral_code).nil?
			#if we have entered this block, it means the code is unique
			referral_unique=1   
		  end

		  #if we found a unique number, we will break out of the loop
		end
		
		@user.referral_code=new_referral_code
		#create the referral



		  if @user.save

			#send the user an email confirmation
			UserMailer.deliver_welcome_email(@user)
			
			#if a user was referred, lets get the user id who referred him and save it
			referrer= User.find(:first, :conditions  => ["referral_code = ?", params['referrer'] ] )
			if !referrer.nil?
			  #if we are here, then the user has been referred by someone.
			  r=Referral.new
			  r.user_id = referrer.id
			  r.new_user = @user.id
			  r.save

			end

			flash[:notice] = 'User was successfully created.'
			redirect_to :action => 'success', :id=>new_referral_code

		  else
			  render :action => "new"
		  end
	end
  end



  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def success

    params[:id]
    

  end


end
