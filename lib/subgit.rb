require 'subgit/version'
require 'subgit/synchronizer'

# Encoding lazarento do windows
# windows_encoding = Encoding::Windows_1252

module Subgit
  # Classe principal da gem
  class Subgit
    def initialize(file, color_output = true)
      @config_file = file
      @colorize = color_output
    end

    def read_and_run
      # Abre o arquivo e faz a leitura
      File.open(@config_file, 'r') do |infile|
        while (line = infile.gets)
          # Split the line
          split_str = line.split '='

          # Pegando o nome do diretorio
          diretorio = split_str[0]
          branch = split_str[1]

          next if diretorio.nil?
          # Rodar os comandos para cada dir
          syncer = Synchronizer.new diretorio, branch.strip
          syncer.update_repo
        end
      end
    end
  end
end
