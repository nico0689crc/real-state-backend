class PropertyAttributesController < ApplicationController
  before_action :set_property_attribute, only: %i[ show update destroy ]

  # GET /property_attributes
  def index
    @property_attributes = PropertyAttribute.all

    render json: @property_attributes
  end

  # GET /property_attributes/1
  def show
    render json: @property_attribute
  end

  # POST /property_attributes
  def create
    @property_attribute = PropertyAttribute.new(property_attribute_params)

    if @property_attribute.save
      render json: @property_attribute, status: :created, location: @property_attribute
    else
      render json: @property_attribute.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /property_attributes/1
  def update
    if @property_attribute.update(property_attribute_params)
      render json: @property_attribute
    else
      render json: @property_attribute.errors, status: :unprocessable_entity
    end
  end

  # DELETE /property_attributes/1
  def destroy
    @property_attribute.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property_attribute
      @property_attribute = PropertyAttribute.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def property_attribute_params
      params.fetch(:property_attribute, {})
    end
end
