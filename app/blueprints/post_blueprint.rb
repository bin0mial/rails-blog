class PostBlueprint < Blueprinter::Base
  fields :id , :title, :body, :created_at

  association :category, blueprint: CategoryBlueprint
end
