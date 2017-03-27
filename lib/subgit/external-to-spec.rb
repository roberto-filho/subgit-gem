#!/usr/bin/env ruby

require_relative 'svnexternal'

EXTERNALS_ROOT_DIR = "~/svn/cooperalfa/Desenv-1.0.3"

projects = []
# Resolve os projetos a serem externalizados
ARGV.each do |project|
  projects.push project
end

PROJECTS_TO_RESOLVE = projects

# svn propget svn:externals -R
def to_external(external_definition_line)
  # Primeiro, divide a linha no espaço
  external = external_definition_line.split

  # A segunda parte (de trás pra frente) é o "link" do repositório
  # Então divide a URL para pegar a parte do branch
  url = external[external.length-2].split "/"
  # Extrai o branch da URL
  branch = url[url.length-1]
  return SvnExternal.new external[external.length-1], branch
end

def resolve_project?(cli_arg)
  return !cli_arg.nil? && cli_arg == "*"  ;
end

# roda o comando no diretório
externals_from_file = `cd #{EXTERNALS_ROOT_DIR} && svn propget svn:externals -R`

externals = externals_from_file.split("\n").select { |i|
  i.size > 1
}

externals.each do |ext|
  external = to_external ext
  #puts external_info.to_array.join ' - '
  puts external.to_property if PROJECTS_TO_RESOLVE.include? external.folder
end
