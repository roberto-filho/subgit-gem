require_relative 'svnexternal'

module Subgit
  EXTERNALS_ROOT_DIR = "~/svn/cooperalfa/Desenv-1.0.3"

  class SpecCreator

    def initialize(root_dir, projects = [])
      @root_dir = root_dir
      @projects = projects
    end

    def format
      # roda o comando no diretório
      # TODO Colocar esse comando em outra classe, para poder mocar
      externals_from_file = `cd #{@root_dir} && svn propget svn:externals -R`
      # Quebra em linhas
      externals = externals_from_file.split("\n").select { |i|
        i.size > 1
      }

      all_externals = []

      externals.each do |ext|
        external = to_external(ext)
        #puts external_info.to_array.join ' - '
        if @projects.include? external.folder or @projects.empty?
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
      # Primeiro, divide a linha no espaço
      external = external_definition_line.split

      # A segunda parte (de trás pra frente) é o "link" do repositório
      # Então divide a URL para pegar a parte do branch
      url = external[external.length-2].split "/"
      # Extrai o branch da URL
      branch = url[url.length-1]
      return Subgit::SvnExternal.new external[external.length-1], branch
    end

    def resolve_project?(cli_arg)
      return !cli_arg.nil? && cli_arg == "*"  ;
    end

  end

end
