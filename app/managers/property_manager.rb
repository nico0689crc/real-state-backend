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
      @object = Property.new(object_params)
      @object.save
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
        facilities
        features
        sq_mts
      ]
    end
end