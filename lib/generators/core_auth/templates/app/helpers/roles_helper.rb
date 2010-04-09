module RolesHelper
  def unless_system(&block)
    unless @role.name == Role::SYSTEM
      content_tag(:div, &block)
    end
  end
end