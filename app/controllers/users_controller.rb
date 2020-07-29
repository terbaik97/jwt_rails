class UsersController < ApplicationController
        # The :authorized method will be called just before the :auto_login , :show  actions.
        before_action :authorized, only: [:auto_login , :show]
    #show only for one 
    #index for all data
    def show
        @user = User.all 
        render json: {user: @user}
    end
    # REGISTER
    def create
        #we dont know who is client , when client used , log
        #need to save a password in hashing 
        exp = Time.now.to_i + 4 * 36
        @user = User.create(user_params)
        if @user.valid?
        @user.password = params[:password_digest]
        puts @user
        @user.save
        token = encode_token({user_id: @user.id, exp: exp})
        render json: {user: @user, token: token}
        else
        render json: {error: "Invalid username or password"}
        end
    end
    # LOGGING IN
    def login
        @user = User.find_by(username: params[:username])
        if @user && @user.password == params[:password_digest]
        token = encode_token({user_id: @user.id})
        render json: {user: @user, token: token}
        else
        render json: {error: "Invalid username or password"}
        end
    end
    def auto_login
        render json: @user
    end
    private
        def user_params
        params.permit(:username,:password_digest , :age)
        end
end
