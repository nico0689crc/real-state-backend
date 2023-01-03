module Api
  module V1
    module Public
      class PropertiesController < PublicController
        before_action :set_property, only: %i[ show update destroy ]

        # GET /properties
        def index
          @presenter = PropertiesPresenter.new(params: params)
          json_response(data: ActiveModel::Serializer::CollectionSerializer.new( @presenter.properties_public, serializer: PropertySerializer))
        end

        # GET /properties/1
        def show
          json_response(data: PropertySerializer.new(@property))
        end

        private

        # Use callbacks to share common setup or constraints between actions.
        def set_property
          @property = Property.find(params[:id])
        end
      end
    end
  end
end
