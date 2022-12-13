module Api
  module V1
    module Admin
      class RealEstatesController < AdminController
        before_action :set_real_estate, only: %i[ show update destroy ]

        # GET /real_estates
        def index
          @presenter = RealEstatesPresenter.new(params: params, current_user: current_user)
          json_response(data: ActiveModel::Serializer::CollectionSerializer.new(@presenter.real_estates, serializer: RealEstateSerializer), presenter: @presenter)
        end

        # GET /real_estates/1
        def show
          json_response(data: RealEstateSerializer.new(@real_estate))
        end

        # POST /real_estates
        def create
          real_estate_manager = RealEstateManager.new(params: params)
        
          if real_estate_manager.create
            json_response(message: I18n.t(:success, scope: %i[messages create]), data: RealEstateSerializer.new(real_estate_manager.object), status: :created)
          else
            json_response(message: I18n.t(:error, scope: %i[messages create]), data: real_estate_manager.object.errors, status: :unprocessable_entity)
          end  
        end

        # PATCH/PUT /real_estates/1
        def update
          real_estate_manager = RealEstateManager.new(params: params, object: @real_estate)
        
          if real_estate_manager.update
            json_response(message: I18n.t(:success, scope: %i[messages update]), status: :no_content)
          else
            json_response(message: I18n.t(:error, scope: %i[messages update]), data: real_estate_manager.object.errors, status: :unprocessable_entity)
          end
        end

        # DELETE /real_estates/1
        def destroy
          real_estate_manager = RealEstateManager.new(object: @real_estate)
        
          if real_estate_manager.destroy
            json_response(message: I18n.t(:success, scope: %i[messages destroy]), status: :no_content)
          else
            json_response(message: I18n.t(:error, scope: %i[messages destroy]), data: real_estate_manager.object.errors, status: :unprocessable_entity)
          end
        end

        private
        
        # Use callbacks to share common setup or constraints between actions.
        def set_real_estate
          @real_estate = RealEstate.find(params[:id])
        end
      end
    end
  end
end
