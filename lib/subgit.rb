require "subgit/version"
require "subgit/synchronizer"

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
            syncer = Synchronizer.new diretorio, branch
            syncer.update_repo
          end
        end
      end

    end
  end

end
