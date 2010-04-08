module RolesHelper
  def unless_system(&block)
    unless @role.name == Role::SYSTEM
      yield
    end
  end
end