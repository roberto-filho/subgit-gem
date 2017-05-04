require "subgit/version"

# Encoding lazarento do windows
#windows_encoding = Encoding::Windows_1252

module Subgit

  class Subgit

    def initialize(file)
      @config_file = file
    end

    def read_and_run
      # Abre o arquivo e lê
      File.open(@config_file, "r") do |infile|
        while (line = infile.gets)
          # Split the line
          split_str = line.split "="

          # Pegando o nome do diretório
          diretorio = split_str[0]
          branch = split_str[1]

          if not diretorio.nil?
            # Rodar os comandos para cada dir
            puts
            puts
            puts "// #{diretorio}, branch: #{branch}" unless diretorio.nil?
            # Faz o fetch do código
            puts "Fetching svn revisions:\n" + `git -C #{diretorio} svn fetch`
            # Verificar se o branch atual é o branch do spec
            current_branch = `git -C #{diretorio} rev-parse --abbrev-ref HEAD`
            if current_branch != branch then
              puts "Branch atual [#{current_branch}] não é o branch da spec [#{branch}]."
              next
            end
            # Atualiza o branch atual
            puts
            puts "Merge:\n\n" + `git -C #{diretorio} merge origin/#{branch}`
          end
        end
      end

    end
  end

end
