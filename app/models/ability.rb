class Ability
  include CanCan::Ability

  def initialize(user)
    # if user.has_role? :admin
    #   can :manage, :all
    # else
    #   can :read, :all
    # end
    user ||= User.new

    alias_action :create, :read, :update, :destroy, to: :crud

    can :read, Project, category: { visible: true } # Here the project can only be read if the category it belongs to is visible. INNRE JOIN
    can :read, Project, active: true, user_id: user.id
    # can :read, Article, is_published: true
    # can :read, Article, author_id: user.id,
    #                     is_published: [false, nil]
    #
    #
    #                   SELECT `articles`.*
    #                   FROM   `articles`
    #                   WHERE  `articles`.`is_published` = 1
    #                   OR     (
    #                                 `articles`.`author_id` = 97
    #                          AND    (
    #                                        `articles`.`is_published` = 0
    #                                 OR     `articles`.`is_published` IS NULL )

    can :crud, User
    can :invite, User
    
    # Adding can rules do not override prior rules, but instead are logically or
    # Adding cannot will override can rule
    
    if user.role? :moderator
      can :manage, Project
      cannot :destroy, Project
      can :manage, Comment
    end
    
    if user.admin? :admin
      can :destroy, Project
    end
    # With Block admin can will override moderator cannot

    can :update, Project do |project|
      project.priority < 3
    end

    if user.has_role? :admin
      can :manage, :all # user can perform any action on any object
    else
      can :read, Forum  # user can read all Forum object
      # can :manage, Forum if user.has_role? (:moderator, Forum)
      can :write, Forum, id: Forum.with_role(:moderator, user).pluck(:id)
    end
    # https://github.com/RolifyCommunity/rolify/wiki/Devise---CanCanCan---rolify-Tutorial
    # https://github.com/CanCanCommunity/cancancan/wiki/defining-abilities
    # https://github.com/CanCanCommunity/cancancan/wiki/Custom-Actions

    # alias_action :index, :show, :to => :read
    # alias_action :new, :to => :create
    # alias_action :edit, :to => :update

  end
end
