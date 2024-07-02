class Api::V1::CollaboratorsController < ApplicationController
  def index
    render json: { message: 'Resource is protected' }
  end
end
