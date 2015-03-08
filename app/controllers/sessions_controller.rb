class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(email: session_params[:email])
		if user && user.authenticate(session_params[:password])
			session[:user_id] = user.id 
			redirect_to root_path
			flash[:notice] = "You are signed in."
		else
			redirect_to login_path
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to('/')
		flash[:notice] = "You are logged out."
	end

	private 

	def session_params
		params.require(:session).permit(:email, :password)
	end


end
