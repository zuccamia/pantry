class RecipePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    # User who created it can edit and update
    user == record.user
  end

  def destroy?
    # User who created it can destroy
    user == record.user
  end
end
