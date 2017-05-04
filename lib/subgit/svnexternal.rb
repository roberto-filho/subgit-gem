module Subgit
  class SvnExternal

    attr_reader :folder, :branch

    def initialize (folder, branch)
      @folder = folder
      @branch = branch
    end

    def to_array
      return [@folder, @branch]
    end

    def to_property
      return "#{folder}=#{branch}"
    end

  end
end
