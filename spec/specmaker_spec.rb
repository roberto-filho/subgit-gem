require 'spec_helper'
require 'subgit/specmaker'

RSpec.describe Subgit::SpecMaker do
  it 'transforma os externals em chaves/valor' do
    allow_any_instance_of(Subgit::Command) \
      .to receive(:get_externals) \
      .and_return File.read('spec/resources/svn-externals.txt')

    maker = Subgit::SpecMaker.new '/some/dir'

    resultado = []
    resultado.push 'something=Something-1.10.1'
    resultado.push 'another=Another-0.0.1'

    expect(maker.format).to eq(resultado)
  end
end
