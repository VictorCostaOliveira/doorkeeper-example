class Api::V1::UsersController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    render json: { message: 'Resource is protected' }
  end
end
