class ToolPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    return true
  end

  def new?
    return create?
  end

  def create?
    return true
  end

  def edit?
    return update?
  end

  def update?
    return user == record.user
    # returns true if current user is the owner
    # returns false if current user is not the owner
  end

  def destroy?
    return user == record.user
  end
end
