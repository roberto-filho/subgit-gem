require 'spec_helper'
require 'subgit/specmaker'

RSpec.describe Subgit::Synchronizer do
  it 'imprime com cor quando configurado' do
    allow_any_instance_of(Subgit::Command) \
      .to receive(:get_current_branch) \
      .and_return 'master'

    allow_any_instance_of(Subgit::Command) \
      .to receive(:fetch_svn_revisions) do |_m, dir|
        puts "Fetched svn revisions on dir '#{dir}'"
      end
    allow_any_instance_of(Subgit::Command).to receive(:merge) do |_m, d, b|
      puts "Merged '#{d}' with branch '#{b}'"
    end

    syncer = Subgit::Synchronizer.new 'home/git/project', 'master'

    syncer.update_repo

    expect_any_instance_of(String).to receive(:colorize)
  end

  it 'imprime sem cor quando configurado' do
    allow_any_instance_of(Subgit::Command) \
      .to receive(:get_current_branch) \
      .and_return 'master'

    allow_any_instance_of(Subgit::Command) \
      .to receive(:fetch_svn_revisions)
  end
end
