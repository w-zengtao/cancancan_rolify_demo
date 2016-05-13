class ForumsController < ApplicationController

  before_action :set_forum, only: [:show, :edit, :update, :destroy]
  before_action :check_user_role_on_forums, only: [:create]
  before_action :check_user_role_on_a_forum, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  # 这里其实就是根据角色在控制层做了一个隔离
  def set_forum
    @forum = Forum.find(params[:id])
  end

  def check_user_role_on_forums
    return ( current_user.has_role? :admin, Forum )
  end

  def check_user_role_on_a_forum
    return ( current_user.has_role? :admin, @forum )
  end

end
