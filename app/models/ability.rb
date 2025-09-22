class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role?(:administrador)
      can :manage, :all
      can :read, :dashboard
      return
    end

    if user.has_role?(:preceptor) || user.has_role?(:docente) || user.has_role?(:alumno)
      can :read, :all
      can :read, :dashboard
      return
    end

    # Invitado (sin roles)
    guest_rules
    can :read, :dashboard
  end

  def guest_rules
    can :read, :publico
  end
end
