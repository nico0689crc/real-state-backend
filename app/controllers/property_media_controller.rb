class PropertyMediaController < ApplicationController
  before_action :set_property_medium, only: %i[ show update destroy ]

  # GET /property_media
  def index
    @property_media = PropertyMedium.all

    render json: @property_media
  end

  # GET /property_media/1
  def show
    render json: @property_medium
  end

  # POST /property_media
  def create
    @property_medium = PropertyMedium.new(property_medium_params)

    if @property_medium.save
      render json: @property_medium, status: :created, location: @property_medium
    else
      render json: @property_medium.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /property_media/1
  def update
    if @property_medium.update(property_medium_params)
      render json: @property_medium
    else
      render json: @property_medium.errors, status: :unprocessable_entity
    end
  end

  # DELETE /property_media/1
  def destroy
    @property_medium.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property_medium
      @property_medium = PropertyMedium.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def property_medium_params
      params.fetch(:property_medium, {})
    end
end
