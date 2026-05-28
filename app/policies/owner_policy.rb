class OwnerPolicy < ApplicationPolicy
  def permitted_attributes
    [:first_name, :last_name, :email, :phone, :address]
  end

  def index?
    user.admin? || user.vet?
  end

  def show?
    user.admin? || user.vet? || record == user.owner
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def edit?
    user.admin? || record == user.owner
  end

  def update?
    user.admin? || record == user.owner
  end

  def destroy?
    user.admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.vet?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end