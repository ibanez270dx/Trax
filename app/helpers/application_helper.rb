module ApplicationHelper

  def flash_class(level)
    case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-error"
    when :alert then "alert alert-error"
    end
  end

  def logged_in?
    current_user.present?
  end

  def active_if_current_page(name)
    controller.action_name.gsub(/_/, '-').downcase==name.gsub(' ', '-').downcase ? 'class=\'active\'' : ''
  end

end
