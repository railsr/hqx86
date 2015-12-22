module Abilities
  class Everyone
    include CanCan::Ability

    def initialize(user)
      can :read, [Build, Comment, Post, Showcase], published: true
      can :read, User #, admin: false
    end
  end
end