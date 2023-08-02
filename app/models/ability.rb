class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.role == 'admin'
      can :manage, :all
    else
      can :read, Recipe
      can :read, Food
      can :read, RecipeFood

      can :create, Recipe
      can :update, Recipe, user_id: user.id
      can :destroy, Recipe, user_id: user.id

      can :create, Food
      can :update, Food, user_id: user.id
      can :destroy, Food, user_id: user.id

      can :create, RecipeFood
      can :update, RecipeFood, food: { user_id: user.id }
      can :destroy, RecipeFood, food: { user_id: user.id }

      can :destroy, Recipe, public: true, user_id: nil
      can :toggle_public, Recipe, user_id: user.id
      can :destroy, RecipeFood, food: { user_id: user.id }
    end
  end
end
