module Api
  module V1
    module Admin
      class PropertiesController < AdminController
        before_action :set_property, only: %i[ show update destroy ]
        before_action :set_media, only: %i[ medias_destroy ]

        # GET /properties
        def index
          @presenter = PropertiesPresenter.new(params: params, current_user: current_user)
          json_response(data: ActiveModel::Serializer::CollectionSerializer.new(@presenter.properties, serializer: PropertySerializer), presenter: @presenter)
        end

        # GET /properties/1
        def show
          json_response(data: PropertySerializer.new(@property))
        end

        # POST /properties
        def create
          property_manager = PropertyManager.new(params: params, current_user: current_user)
        
          if property_manager.create
            json_response(message: I18n.t(:success, scope: %i[messages create]), data: PropertySerializer.new(property_manager.object), status: :created)
          else
            json_response(message: I18n.t(:error, scope: %i[messages create]), data: property_manager.object.errors, status: :unprocessable_entity)
          end  
        end

        # PATCH/PUT /properties/1
        def update
          property_manager = PropertyManager.new(params: params, current_user: current_user, object: @property)
        
          if property_manager.update
            json_response(message: I18n.t(:success, scope: %i[messages update]), status: :no_content)
          else
            json_response(message: I18n.t(:error, scope: %i[messages update]), data: property_manager.object.errors, status: :unprocessable_entity)
          end
        end

        # DELETE /properties/1
        def destroy
          property_manager = PropertyManager.new(object: @property)
        
          if property_manager.destroy
            json_response(message: I18n.t(:success, scope: %i[messages destroy]), status: :no_content)
          else
            json_response(message: I18n.t(:error, scope: %i[messages destroy]), data: property_manager.object.errors, status: :unprocessable_entity)
          end
        end

        def medias_destroy
          property_manager = PropertyManager.new(object: @media)
        
          if property_manager.medias_destroy
            json_response(message: I18n.t(:success, scope: %i[messages destroy]), status: :no_content)
          else
            json_response(message: I18n.t(:error, scope: %i[messages destroy]), data: property_manager.object.errors, status: :unprocessable_entity)
          end
        end

        private
          # Use callbacks to share common setup or constraints between actions.
          def set_property
            @property = Property.find(params[:id])
          end

          def set_media
            @media = Property.find(params[:property_id]).medias.attachments.find(params[:id])
          end
      end
    end
  end
end
