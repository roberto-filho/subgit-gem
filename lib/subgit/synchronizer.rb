require "colorize"
# Encoding lazarento do windows
#windows_encoding = Encoding::Windows_1252

module Subgit

  class Synchronizer

    def initialize(dir, branch)
      @dir = dir
      @branch = branch
    end

    def update_repo
      # Rodar os comandos para cada dir
      puts
      puts
      puts "// #{@dir}, branch: #{@branch}" unless diretorio.nil?
      # Faz o fetch do código
      puts "Fetching svn revisions:\n" + `git -C #{@dir} svn fetch`
      # Verificar se o branch atual é o branch do spec
      current_branch = `git -C #{@dir} rev-parse --abbrev-ref HEAD`
      if current_branch != branch then
        puts "Branch atual [#{current_branch.strip}] não é o branch da spec [#{@branch.strip}].".colorize(:yellow)
        next
      end
      # Atualiza o branch atual
      puts 
      puts "Merge:\n\n" + `git -C #{@dir} merge origin/#{@branch}`
    end
  end

end
