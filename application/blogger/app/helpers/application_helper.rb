module ApplicationHelper

  def active_for(controller, action = nil)
    action = action.nil? ? action_name : action
    if controller_name == controller && action == action_name
      return 'active'
    end
  end
end
