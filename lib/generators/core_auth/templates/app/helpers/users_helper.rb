module UsersHelper
  def unless_admin(&block)
    unless @user.admin?
      content_tag(:span, &block)
    end
  end
end