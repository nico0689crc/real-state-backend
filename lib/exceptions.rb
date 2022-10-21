class CustomException < Exception
  def initialize(message: "Custom Exception", status: :unprocessable_entity)
    @status = status
    super(message)
  end
end
