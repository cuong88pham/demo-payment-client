class ApplicationPolicy
  attr_reader :manager, :record

  def initialize(manager, record)
    @manager = manager
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    attr_reader :manager, :scope

    def initialize(manager, scope)
      @manager = manager
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
