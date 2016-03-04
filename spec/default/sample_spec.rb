require 'spec_helper'

describe command("ruby -v") do
    its(:stdout) { should match /ruby 2\.3\.0p0.+/ }
end

