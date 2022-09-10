class PropertyManager 
    attr_reader :object

    def initialize(params: nil, object: nil)
      @params = params    if params.present?
      @object = object    if object.present?
    end
  
    def build
      Property.new
    end
  
    def create
      # binding.pry
      ActiveRecord::Base.transaction do
        @object = Property.new(object_params)
        if @object.save!
  
          unless @object.medias.attach(@params[:property][:medias])
            raise ActiveRecord::Rollback
            false
          end

          JSON.parse(@params[:property][:facilities]).each do |facility|
            property_attribute = PropertyAttribute.new(
              name: facility["name"],
              icon_name: facility["icon_name"],
              important: facility["important"],
              p_attribute_type: "facility",
              property: @object
            )
          
            unless property_attribute.save
              raise ActiveRecord::Rollback
              false
            end
          end if @params[:property].present? && @params[:property][:facilities].present?

          JSON.parse(@params[:property][:features]).each do |feature|
            property_attribute = PropertyAttribute.new(
              name: feature["name"],
              icon_name: feature["icon_name"],
              important: feature["important"],
              p_attribute_value: feature["value"],
              p_attribute_type: "feature",
              property: @object
            )

            unless property_attribute.save
              raise ActiveRecord::Rollback
              false
            end
          end if @params[:property].present? && @params[:property][:facilities].present?
        else
          raise ActiveRecord::Rollback
          false
        end
      end
    end
  
    def update
      @object.update(object_params)
    end
  
    def destroy
      @object.destroy
    end
  
    private
  
    def object_params
      @params.require(:property).permit(permitted_params)
    end
  
    def permitted_params
      %i[
        title
        description
        p_type
        p_status
        operating_since
        price
        address
        coordinates
        sq_mts
        medias
        bathroom_amount
        beedroom_amount
      ]
    end
end