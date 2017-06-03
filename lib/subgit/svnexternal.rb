module Subgit
  # Representa um external do SVN
  class SvnExternal
    attr_reader :folder, :branch

    def initialize(folder, branch)
      @folder = folder
      @branch = branch
    end

    def to_array
      [@folder, @branch]
    end

    def to_property
      "#{folder}=#{branch}"
    end
  end
end
