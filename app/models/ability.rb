# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    # если не залогинен, считаем читателем (guest)
    user ||= User.new(role: 'reader')

    if user.admin?
      # администратор управляет всем — в том числе пользователями
      can :manage, :all

    elsif user.librarian?
      # библиотекарь управляет книгами и записями аренды …
      can :manage, Book
      can :manage, Rental

      cannot :manage, User
      cannot :read, User

    else
      # читатель видит каталог и свои аренды
      cannot :read, Book
      can :create, Rental
      cannot :read, Rental, user_id: user.id

      # не имеет никаких прав по пользователям
      cannot :manage, User
    end
  end
end
