require 'htmlentities'

module ApplicationHelper
  def destroy_field(f)
    f.input :_destroy, :as => "hidden", :input_html => { :class => "destroy" }
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    coder = HTMLEntities.new
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
  
end
