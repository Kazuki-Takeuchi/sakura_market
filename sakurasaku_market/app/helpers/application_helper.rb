module ApplicationHelper
  def is_admin?
    user_signed_in? && current_user.administrator?
  end
end
