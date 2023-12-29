class ServicePolicy
  attr_reader :user, :service

  def initialize(user, service)
    @user = user
    @service = service
  end

  def create?
    user.seller?
  end
end
