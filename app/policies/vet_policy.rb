class VetPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def edit?
    user.admin? || record == user.vet
  end

  def update?
    user.admin? || record == user.vet
  end

  def destroy?
    user.admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end