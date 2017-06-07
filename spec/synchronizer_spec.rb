require 'spec_helper'
require 'subgit/specmaker'

RSpec.describe Subgit::Synchronizer do
  it 'imprime com cor quando configurado' do
    allow_any_instance_of(Subgit::Command) \
      .to receive(:get_externals) \
      .and_return File.read('spec/resources/svn-externals-com-path.txt')

    maker = Subgit::SpecMaker.new '/some/dir'

    resultado = []
    resultado.push 'something=Something-1.10.1'
    resultado.push 'another=Another-0.0.1'

    expect(maker.format).to eq(resultado)
  end

  it 'imprime com cor quando configurado' do
    allow_any_instance_of(Subgit::Command) \
      .to receive(:get_current_branch) \
      .and_return 'master'

    allow_any_instance_of(Subgit::Command) \
      .to receive(:fetch_svn_revisions) \
      .and_do_nothing
  end
end
