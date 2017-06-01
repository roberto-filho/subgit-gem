require 'colorize'
require_relative 'commands'
# Encoding lazarento do windows
#windows_encoding = Encoding::Windows_1252

module Subgit

  class Synchronizer include Subgit

    def initialize(dir, branch)
      @dir = dir
      @branch = branch
    end

    def update_repo
      # Rodar os comandos para cada dir
      puts
      puts
      puts "// #{@dir}, branch: #{@branch}" unless @dir.nil?
      # Faz o fetch do código
      puts "Fetching svn revisions:\n" + fetch_svn_revisions(@dir)
      # Verificar se o branch atual é o branch do spec
      current_branch = get_current_branch @dir
      if current_branch != @branch then
        puts "Branch atual [#{current_branch.strip}] não é o branch da spec [#{@branch.strip}].".colorize(:yellow)
      else
        # Atualiza o branch atual
        puts
        puts "Merge:\n\n" + merge(@dir, @branch)
      end
    end
  end

  private
  def fetch_svn_revisions(dir)
    `git -C #{dir} svn fetch`
  end

end
