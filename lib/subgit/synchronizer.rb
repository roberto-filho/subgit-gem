require 'colorize'
require 'subgit/commands'
# Encoding lazarento do windows
# windows_encoding = Encoding::Windows_1252

module Subgit
  # Faz a sincronizacao de um diretorio com um branch
  class Synchronizer
    include Command

    def initialize(dir, branch)
      @dir = dir
      @spec_branch = branch.strip
    end

    # Atualiza um repositorio e faz merge
    def update_repo
      # Rodar os comandos para cada dir
      puts
      puts
      output("// #{@dir}, branch: #{@spec_branch}", :green) unless @dir.nil?
      # Faz o fetch do codigo
      puts 'Fetching svn revisions:'
      puts fetch_svn_revisions(@dir)
      # Verificar se o branch atual eh o branch do spec
      current_branch = get_current_branch(@dir).strip
      if current_branch != @spec_branch
        puts output("Branch atual [#{current_branch.strip}] " \
          "não é o branch da spec [#{@spec_branch.strip}]." \
          , :yellow)
      else
        # Atualiza o branch atual
        puts
        puts 'Merge:'.colorize(:green)
        puts
        puts merge(@dir, @spec_branch)
      end
    end

    private

    # Loga uma mensagem na tela
    def output(text, color)
      if @colorize
        puts text
      else
        puts text.colorize(color)
      end
    end
  end
end
