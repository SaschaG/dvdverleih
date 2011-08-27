q2 class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def create
	if user.id = 1
		user.role = "Administrator"
	else
		user.role = "Kunde"
	end
  end

end
