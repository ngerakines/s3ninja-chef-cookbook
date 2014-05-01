require 'chefspec'
require 'chefspec/berkshelf'
ChefSpec::Coverage.start!

platforms = {
  "ubuntu" => ['12.04', '13.10'],
  "centos" => ['5.9', '6.5']
}

describe 's3ninja::deployment' do
  platforms.each do |platform_name, platform_versions|
    platform_versions.each do |platform_version|

      context "on #{platform_name} #{platform_version}" do

        let(:chef_run) do
          ChefSpec::Runner.new(platform: platform_name, version: platform_version) do |node|
            node.set['lsb']['codename'] = 'foo'
          end.converge('s3ninja::deployment')
        end

        it 'places the init script and starts the service' do
          expect(chef_run).to create_template('/etc/init.d/s3ninja')
          expect(chef_run).to start_service('s3ninja')
        end

      end

    end
  end

end
