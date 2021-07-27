class PostPolicy < ApplicationPolicy
  def owned
    record.creator.id == user.id if !user.nil?
  end

  def index?
    true
  end

  def show?
    true
  end

  def edit?
    owned
  end

  def new?
    !user.nil?
  end

  def create?
    !user.nil?
  end

  def destroy?
    owned
  end

  def update?
    owned
  end
end
