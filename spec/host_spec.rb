# # encoding: utf-8

# Inspec test for recipe install-py-rb-go::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Check command
RSpec.shared_context 'check_command' do
	its('stderr') { should eq '' }
	its('exit_status') { should eq 0 }
end

# check host
# commands = ["docker", "docker-compose", "kubectl", "rake", "inspec"]
commands = ["docker", "docker-compose", "rake", "inspec"]
commands.each{|command_name|
	describe command(command_name) do
		it { should exist }
	end
}

describe docker_image('prom/prometheus:v2.6.1') do
	it { should exist }
	# its('tag') { should eq 'v2.6.1' }
end
