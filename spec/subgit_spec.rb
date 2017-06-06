require 'spec_helper'
require 'subgit/specmaker'

RSpec.describe Subgit do
  it 'has a version number' do
    expect(Subgit::VERSION).not_to be nil
  end

  # it 'does something useful' do
  #   expect(false).to eq(true)
  # end

  it 'transforma os externals em "branches"' do
    allow_any_instance_of(Subgit::Command) \
      .to receive(:get_externals) \
      .and_return File.read('spec/resources/svn-externals.txt')

    maker = Subgit::SpecMaker.new '/some/dir'

    resultado = []
    resultado.push 'Something-Parent=Something-1.10.1'
    resultado.push 'Another-Parent=Another-0.0.1'

    expect(maker.format).to eq(resultado)
  end
end
