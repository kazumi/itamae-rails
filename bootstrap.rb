# from http://techlife.cookpad.com/entry/2015/05/12/080000

module RecipeHelper
  def include_cookbook(name)
    include_recipe File.join(__dir__, "cookbooks", name, "default.rb")
  end
end

require 'yaml'
secret = YAML.load_file("secret.yml")
node[:secret] = secret

Itamae::Recipe::EvalContext.include(RecipeHelper)

include_recipe File.join("roles", node[:role], "default.rb")
