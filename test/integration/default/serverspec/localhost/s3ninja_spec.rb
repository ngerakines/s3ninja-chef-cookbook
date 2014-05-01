require 'spec_helper'

describe 's3ninja' do

  describe 'app' do

    describe file('/home/s3ninja') do
      it { should be_directory }
    end

    describe file('/home/s3ninja/sirius.sh') do
      it { should be_file }
      it { should be_executable }
    end

  end

  describe 'service' do

    describe file('/etc/init.d/s3ninja') do
      it { should be_file }
    end

    describe port(9444) do
      it { should be_listening }
    end

    describe command('/home/s3ninja/upload.sh localhost:9444 test-bucket hello_world.txt "hello world"') do
      it { should return_exit_status 0 }
    end

    describe file('/home/s3ninja/s3/test-bucket/hello_world.txt') do
      it { should be_file }
      it { should contain 'hello world' }
    end

    describe command('/home/s3ninja/get.sh localhost:9444 test-bucket hello_world.txt') do
      its(:stdout) { should match /hello world/ }
    end

  end

end

