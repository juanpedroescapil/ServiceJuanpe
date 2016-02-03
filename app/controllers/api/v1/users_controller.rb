class Api::V1::UsersController < ApplicationController
  
  respond_to :json
  http_basic_authenticate_with :name => "juanpe", :password => "12493923"

  skip_before_filter  :verify_authenticity_token
  skip_before_filter :authenticate_user! 
  # GET /users.json
  def index
   @users = User.all
   respond_with(@users)
  end
 
  # POST /users.json
  def create
   @user = User.new(user_params)
   if @user.save
    render :json => {'status':'success'}
   else
    respond_with({'status':'error', 'errors':@user.errors})
   end
  end
   
  # PATCH/PUT /users/1.json
  def update
   if @user.update(user_params)
    respond_with({'status':'success'})
   else
    respond_with({'status':'error'})
   end
  end
 
  # DELETE /users/1.json
  def destroy
   @user.destroy
   respond_with({'status':'User deleted'})
  end
 
 private 
  
  def user_params
   params.require(:user).permit(:name, :last_name, :phone_number)
  end
 
end