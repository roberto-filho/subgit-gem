module Subgit
  # Comandos utilizados no subgit
  module Command
    # TODO: color.ui=always
    # TODO: color.status=always
    # Como fazer para passar esses caras no construtor das classes?
    def get_externals(dir)
      `cd #{dir} && svn propget svn:externals -R`
    end

    def fetch_svn_revisions(dir)
      `git -C #{dir} svn fetch`
    end

    def get_current_branch(dir)
      `git -C #{dir} rev-parse --abbrev-ref HEAD`
    end

    def merge(dir, branch, remote = 'origin')
      `git -C #{dir} merge #{remote}/#{branch}`
    end
  end
end
