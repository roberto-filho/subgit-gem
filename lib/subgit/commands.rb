module Subgit
  # TODO Separar logicamente esses metodos? ex: Subgit::Commands::current_branch
  def get_externals(dir)
    `cd #{dir} && svn propget svn:externals -R`
  end

  def fetch_svn_revisions(dir)
    `git -C #{dir} svn fetch`
  end

  def get_current_branch(dir)
    `git -C #{dir} rev-parse --abbrev-ref HEAD`
  end

  def merge(dir, branch, remote = "origin")
    `git -C #{dir} merge #{remote}/#{branch}`
  end
end
