class BaseManager
  attr_reader :object

  def initialize(params: nil, object: nil, current_user: nil)
    @params = params if params.present?
    @object = object if object.present?
    @current_user = current_user if current_user.present?
  end

  def build
    klass.new
  end

  def create
    @object = klass.new(object_params)
    @object.save
  end

  def update
    @object.update(object_params)
  end

  def destroy
    @object.destroy
  end

  def klass
    raise StandardError, "It must be defined in subclass"
  end

  private

  def object_params
    @params.require(klass.to_s.underscore.to_sym).permit(permitted_params)
  end

  def permitted_params
    raise StandardError, "It must be defined in permitted_params"
  end
end
