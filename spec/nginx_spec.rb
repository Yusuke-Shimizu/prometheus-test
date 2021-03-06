# # encoding: utf-8

# Inspec test for recipe install-py-rb-go::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Check command
RSpec.shared_context 'check_command' do
	its('stderr') { should eq '' }
	its('exit_status') { should eq 0 }
end

# check prometheus site
describe file('/usr/share/nginx/html') do
	it { should exist }
end

# check prometheus site
# describe http('http://prometheus:9090/metrics') do
# 	its('status') { should cmp 200 }
# 	its('body') { should include 'go_gc_duration_seconds' }
# 	# its('body') { should include 'prometheus_http_response_size_bytes' }
# end
describe command("wget http://prometheus:9090/metrics -q") do
	include_context 'check_command'
end
describe file('/metrics') do
	it { should exist }
	its('content') { should match(/go_gc_duration_seconds/) }
end
describe command("rm -f metrics") do
	include_context 'check_command'
end
#describe file('/metrics') do
#	it { should_not exist }
#end

# check grafana site
describe command("wget http://grafana:3000/login -q") do
	include_context 'check_command'
end
describe file('/login') do
	it { should exist }
end
describe command("rm -f login") do
	include_context 'check_command'
end
