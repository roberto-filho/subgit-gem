require 'subgit/commands'
require 'subgit/svnexternal'

module Subgit
  # Cria um arquivo de spec
  class SpecMaker
    include Command

    def initialize(root_dir, projects = [])
      @root_dir = root_dir
      @projects = projects
    end

    def format
      # roda o comando no diretorio
      # TODO Colocar esse comando em outra classe, para poder mocar
      externals_from_file = get_externals(@root_dir)
      # Quebra em linhas
      externals = externals_from_file.split("\n").select { |i| i.size > 1 }

      all_externals = []

      externals.each do |ext|
        external = to_external(ext)
        # puts external_info.to_array.join ' - '
        if @projects.include?(external.folder) || @projects.empty?
          all_externals.push external.to_property
        end
      end
      # retorna os caras
      all_externals
    end

    def print_formatted
      all = format
      puts all.join "\n"
    end

    private

    def to_external(external_definition_line)
      # Primeiro, divide a linha no espaco
      external = external_definition_line.split

      # A segunda parte (de tras pra frente) eh o "link" do repositorio
      # Entao divide a URL para pegar a parte do branch
      url = external[external.length - 2].split '/'
      # Extrai o branch da URL
      branch = url[url.length - 1]

      Subgit::SvnExternal.new external[external.length - 1], branch
    end
  end
end
