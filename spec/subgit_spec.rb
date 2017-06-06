require 'spec_helper'
require 'subgit/specmaker'

RSpec.describe Subgit do
  it 'has a version number' do
    expect(Subgit::VERSION).not_to be nil
  end

  # it 'does something useful' do
  #   expect(false).to eq(true)
  # end
end
