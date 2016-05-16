require 'active_support/concern'

module RolifyConcern
  extend ActiveSupport::Concern
  
  included do
    def add_class_role(klass, role, id = nil)    
      id.blank? ? (self.add_role role.to_sym, klass.capitalize.constantize) : (self.add_role role.to_sym, klass.capitalize.constantize.find(id))
    end
  end
  
  class_methods do
  end
end


# module M
#   def self.included(base)
#     base.extend ClassMethods
#     base.class_eval do
#       scope :disabled, -> { where(disabled: true) }
#     end
#   end
#
#   module ClassMethods
#     ...
#   end
# end