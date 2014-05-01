require 'chefspec'
require 'chefspec/berkshelf'
ChefSpec::Coverage.start!

platforms = {
  "ubuntu" => ['12.04', '13.10'],
  "centos" => ['5.9', '6.5']
}

describe 's3ninja::default' do
  platforms.each do |platform_name, platform_versions|
    platform_versions.each do |platform_version|

      context "on #{platform_name} #{platform_version}" do

        let(:chef_run) do
          ChefSpec::Runner.new(platform: platform_name, version: platform_version) do |node|
            node.set['lsb']['codename'] = 'foo'
          end.converge('s3ninja::default')
        end

        it 'Includes dependent receipes' do
          expect(chef_run).to include_recipe('s3ninja::app')
          expect(chef_run).to include_recipe('s3ninja::deployment')
        end

      end

    end
  end

end
