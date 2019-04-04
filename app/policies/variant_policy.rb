class VariantPolicy < ApplicationPolicy
  def images?
    true
  end

  def all?
    true
  end

  def latest?
    all?
  end

  def sale?
    all?
  end

  def show?
    true
  end

  def index?
    user&.is_editor?
  end

  def update?
    user&.is_editor?
  end

  def destroy?
    update?
  end

  def wishlist?
    user
  end

  def cart?
    user
  end
end
