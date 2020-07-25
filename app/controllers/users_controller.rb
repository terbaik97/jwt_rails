class UsersController < ApplicationController
        before_action :authorized, only: [:auto_login]

    def show
        @user = User.all 
        render json: {user: @user}
    end
    # REGISTER
    def create
        @user = User.create(user_params)
        if @user.valid?
        @user.save
        token = encode_token({user_id: @user.id})
        render json: {user: @user, token: token}
        else
        render json: {error: "Invalid username or password"}
        end
    end
    # LOGGING IN
    def login
        @user = User.find_by(username: params[:username])
        if @user && @user.password_digest == params[:password_digest]
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
        params.permit(:username, :password_digest, :age)
        end
end
