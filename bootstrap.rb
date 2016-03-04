# from http://techlife.cookpad.com/entry/2015/05/12/080000

module RecipeHelper
  def include_cookbook(name)
    include_recipe File.join(__dir__, "cookbooks", name, "default.rb")
  end
end

Itamae::Recipe::EvalContext.include(RecipeHelper)

include_recipe File.join("roles", node[:role], "default.rb")
