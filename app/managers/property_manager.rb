class PropertyManager < BaseManager
  def klass
    Property
  end
  
  def create
    ActiveRecord::Base.transaction do
      @object = Property.new(object_params)
      @object.user = @current_user

      if @current_user.super_administrator?
        @object.real_estate_id = @params[:property][:real_estate]
      else
        @object.real_estate = @current_user.real_estate
      end

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
    ActiveRecord::Base.transaction do
      if @current_user.super_administrator?
        @object.real_estate_id = @params[:property][:real_estate]
      else
        @object.real_estate = @current_user.real_estate
      end

      if @object.update(object_params)
        if @object.medias.attach(@params[:property][:medias])
          true
        else
          raise ActiveRecord::Rollback
          false
        end
      else
        raise ActiveRecord::Rollback
        false
      end
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      if @object.medias.attachments.purge
        @object.destroy
      else
        raise ActiveRecord::Rollback
        false
      end
    end
  end

  def medias_destroy
    @object.purge_later
  end

  private

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