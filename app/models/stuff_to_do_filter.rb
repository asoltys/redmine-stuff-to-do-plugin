class StuffToDoFilter
  attr_accessor :users
  attr_accessor :priorities
  attr_accessor :statuses
  
  def initialize
    self.users = User.active
    self.priorities = IssuePriority.find(:all)
    self.statuses = IssueStatus.find(:all)
  end
  
  def each
    if StuffToDo.using_issues_as_items?
      {
        :users => self.users.sort,
        :priorities => self.priorities.sort,
        :statuses => self.statuses.sort
      }.each do |group, items|
        yield group, items
      end
    end

    # Finally projects
    yield :projects if StuffToDo.using_projects_as_items?
  end
end
