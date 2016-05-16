class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Rolify & Rolify Callbacks
  rolify before_add: :before_add_method, after_add: :after_add_method, strict: true
  
  # Concern
  include RolifyConcern

  def before_add_method (role)
    puts self.id.to_s + ' ' + role.name + ' is going to be add'
  end

  def after_add_method (role)
    puts self.id.to_s + ' ' + role.name + ' was added'
  end
  
  # Cached Roles (Avoid N+1)
  # users = User.with_role(:admin, Forum).preload(:roles)
  # users.each do |user|
  #   user.has_cached_role?(:member, Forum) # no extra queries
  # end
  
  
end
