class RecipeAmountPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def destroy?
    # User who created it can destroy
    user == record.user
  end
end
