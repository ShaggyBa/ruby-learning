class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # гость

    if user.role == 'admin'
      can :manage, :all
    elsif user.role == 'librarian'
      can :manage, Book # например, библиотекарь может управлять книгами
    else
      can :read, Book
    end
  end
end
