class RealEstateManager < BaseManager
  def klass
    RealEstate
  end

  def create
    ActiveRecord::Base.transaction do
      @object = RealEstate.new(
        name: @params[:real_estate][:name],
        address: @params[:real_estate][:address],
        description: @params[:real_estate][:description],
        contact_phone: @params[:real_estate][:contact_phone],
        contact_email: @params[:real_estate][:contact_email]
      )

      if @object.save!
        RealEstateUser.create!({
          first_name: @params[:real_estate][:real_estate_user_responsible_attributes][:first_name],
          last_name: @params[:real_estate][:real_estate_user_responsible_attributes][:last_name],
          email: @params[:real_estate][:real_estate_user_responsible_attributes][:email],
          user_role: :real_estate_administrator,
          password: @params[:real_estate][:real_estate_user_responsible_attributes][:password],
          password_confirmation: @params[:real_estate][:real_estate_user_responsible_attributes][:password_confirmation],
          real_estate: @object,
          real_estate_responsible: @object
        })
      else
        raise ActiveRecord::Rollback
        false
      end
    end
  end

  private

  def permitted_params
    [
      :name,
      :address,
      :description,
      :contact_phone,
      :contact_email,
      real_estate_user_responsible_attributes: [
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation
      ]
    ]
  end
end