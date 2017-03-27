# Encoding lazarento do windows
windows_encoding = Encoding::Windows_1252

class Subgit

  def initialize(file)
    @file = file
  end

  def read_and_run
    # Abre o arquivo e lê
    File.open(@file, "r") do |infile|
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
          # TODO Verificar se o branch atual é o branch do spec
          current_branch = `git -C #{diretorio} rev-parse --abbrev-ref HEAD`
          if current_branch != branch then
            puts "Branch atual [#{current_branch}] não é o branch da spec [#{branch}]."
            exit 1
          end
          # Atualiza o branch atual
          puts
          puts "Merge:\n\n" + `git -C #{diretorio} merge origin/#{branch}`
        end
      end
    end

  end
end
# Lê o arquivo passado para ele
file = ARGV[0]

# File.open(ARGV[0], "r", encoding: windows_encoding) do |infile|
