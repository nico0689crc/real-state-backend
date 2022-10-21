module Api
  module V1
    module Admin
      class UsersController < AdminController
        before_action :set_user, only: %i[ show update destroy ]

        # GET /users
        def index
          @presenter = UsersPresenter.new(params)
          json_response(data: ActiveModel::Serializer::CollectionSerializer.new(@presenter.users, serializer: UserSerializer), presenter: @presenter)
        end

        # GET /users/1
        def show
          json_response(data: UserSerializer.new(@user))
        end

        # POST /users
        def create
          user_manager = UserManager.new(params: params, current_user: current_user)
        
          if user_manager.create
            json_response(message: I18n.t(:success, scope: %i[messages create]), data: UserSerializer.new(user_manager.object), status: :created)
          else
            json_response(message: I18n.t(:error, scope: %i[messages create]), data: user_manager.object.errors, status: :unprocessable_entity)
          end  
        end

        # PATCH/PUT /users/1
        def update
          user_manager = UserManager.new(params: params, object: @user)
        
          if user_manager.update
            json_response(message: I18n.t(:success, scope: %i[messages update]), status: :no_content)
          else
            json_response(message: I18n.t(:error, scope: %i[messages update]), data: user_manager.object.errors, status: :unprocessable_entity)
          end
        end

        # DELETE /users/1
        def destroy
          user_manager = UserManager.new(object: @user, current_user: current_user)
        
          if user_manager.destroy
            json_response(message: I18n.t(:success, scope: %i[messages destroy]), status: :no_content)
          else
            json_response(message: I18n.t(:error, scope: %i[messages destroy]), data: user_manager.object.errors, status: :unprocessable_entity)
          end
        end

        private
          # Use callbacks to share common setup or constraints between actions.
          def set_user
            @user = User.find(params[:id])
          end
      end
    end
  end
end
