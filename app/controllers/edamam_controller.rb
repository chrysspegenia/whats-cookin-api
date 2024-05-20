class EdamamController < ApplicationController
    # before_action :set_recipe, only: [:show]
  
    def recipes
      @recipes = client.recipes(q: "chicken")
      render json: @recipes, each_serializer: RecipeSerializer
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  
    private
  
    def client
      Edamam::V1::Client.new
    end
  end
  