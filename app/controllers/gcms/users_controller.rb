module Gcms
  class UsersController < ApplicationController
    before_action :authenticate_gcms_user!
    load_and_authorize_resource
    skip_authorize_resource only: :gcms_user

    def index
      render json: User.all.to_json(except: [:created_at, :updated_at], methods: :localized_role)
    end

    def create
      user_params.merge!(password: params[:password], password_confirmation: params[:password_confirmation]) if params[:password]
      @user = User.new(user_params)
      @user.save
      render json: @user.to_json
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      render json: @user.to_json
    end

    def gcms_user
      render json: current_gcms_user.to_json
    end

    protected

    def user_params
      params.require(:user).permit!
    end


  end
end
