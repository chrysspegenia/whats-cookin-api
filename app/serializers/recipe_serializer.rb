class RecipeSerializer
    include JSONAPI::Serializer
    attributes :uri, :label, :image, :source
  
    # has_many :tasks
  end
  