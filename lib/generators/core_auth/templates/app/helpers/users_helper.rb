module UsersHelper
  def unless_admin
    unless @user.admin?
      yield
    end
  end
end