class AppointmentPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? ||
      (user.vet? && record.vet == user.vet) ||
      (user.owner? && record.pet&.owner == user.owner)
  end

  def new?
    user.admin? || user.vet? || user.owner?
  end

  def create?
    user.admin? || user.vet? || user.owner?
  end

  def edit?
    user.admin? ||
      (user.vet? && record.vet == user.vet) ||
      (user.owner? && record.pet&.owner == user.owner)
  end

  def update?
    user.admin? ||
      (user.vet? && record.vet == user.vet) ||
      (user.owner? && record.pet&.owner == user.owner)
  end

  def destroy?
    user.admin? ||
      (user.vet? && record.vet == user.vet) ||
      (user.owner? && record.pet&.owner == user.owner)
  end

  def permitted_attributes
    if user.admin?
      [:date, :reason, :status, :pet_id, :vet_id]
    elsif user.vet?
      [:date, :reason, :status, :pet_id, :vet_id]
    else
      [:date, :reason, :status, :pet_id, :vet_id]
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.vet? && user.vet
        scope.where(vet: user.vet)
      elsif user.owner? && user.owner
        scope.joins(pet: :owner).where(owners: { id: user.owner.id })
      else
        scope.none
      end
    end
  end
end