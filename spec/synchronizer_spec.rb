require 'spec_helper'
require 'subgit/specmaker'

RSpec.describe Subgit::Synchronizer do
  context 'quando branch atual nao eh o branch da spec' do
    before(:each) do
      setup_mocks 'other-branch'
    end

    it 'nao deve fazer merge' do
      spec_branc = 'master'
      syncer = Subgit::Synchronizer.new 'home/git/project', spec_branc

      expect_any_instance_of(Subgit::Command).not_to receive(:merge)

      syncer.update_repo
    end
  end

  context 'quando branch atual eh o branch da spec' do
    before(:each) do
      setup_mocks 'master'
    end

    it 'deve fazer merge' do
      spec_branc = 'master'
      syncer = Subgit::Synchronizer.new 'home/git/project', spec_branc

      expect_any_instance_of(Subgit::Command).to receive(:merge)

      syncer.update_repo
    end
  end

  private

  def setup_mocks(git_branch)
    allow_any_instance_of(Subgit::Command) \
      .to receive(:get_current_branch) \
      .and_return git_branch

    allow_any_instance_of(Subgit::Command) \
      .to receive(:fetch_svn_revisions) do |_m, dir|
        puts "Fetched svn revisions on dir '#{dir}'"
      end

    allow_any_instance_of(Subgit::Command).to receive(:merge) do |_m, d, b|
      puts "Merged '#{d}' with branch '#{b}'"
    end
  end
end
