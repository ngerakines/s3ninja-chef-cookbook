require 'chefspec'
require 'chefspec/berkshelf'
ChefSpec::Coverage.start!

platforms = {
  "ubuntu" => ['12.04', '13.10'],
  "centos" => ['5.9', '6.5']
}

describe 's3ninja::app' do
  platforms.each do |platform_name, platform_versions|
    platform_versions.each do |platform_version|

      context "on #{platform_name} #{platform_version}" do

        let(:chef_run) do
          ChefSpec::Runner.new(platform: platform_name, version: platform_version) do |node|
            node.set['lsb']['codename'] = 'foo'
          end.converge('s3ninja::app')
        end

        it 'includes dependent receipes' do
          expect(chef_run).to include_recipe('apt')
          expect(chef_run).to include_recipe('yum')
          expect(chef_run).to include_recipe('java')
        end

        it 'creates the user and groups' do
          expect(chef_run).to create_user('s3ninja')
          expect(chef_run).to create_group('s3ninja')
        end

        it 'installs required packages' do
          expect(chef_run).to install_package('curl')
          expect(chef_run).to install_package('unzip')
        end

        it 'downloads and unpacks the application package' do
          expect(chef_run).to create_remote_file('/var/chef/cache/s3ninja.zip')
          expect(chef_run).to run_bash('extract_app')
          expect(chef_run).to run_execute('chown -R s3ninja:s3ninja /home/s3ninja/')
          expect(chef_run).to create_file('/home/s3ninja/sirius.sh')
          expect(chef_run).to create_cookbook_file('/home/s3ninja/get.sh')
          expect(chef_run).to create_cookbook_file('/home/s3ninja/upload.sh')
        end
      end

    end
  end

end
