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
describe file('/etc/prometheus/prometheus.yml') do
	it { should exist }
	its('content') { should match(/node_exporter/) }
end

# check grafana site
# describe host('grafana', port: 3000, protocol: 'tcp') do
# 	it { should be_reachable }
# 	it { should be_resolvable }
# 	# its('ipaddress') { should include '12.34.56.78' }
# end

# connect node
describe command("wget http://node_exporter:9100/metrics -q") do
	include_context 'check_command'
end
describe file('/etc/prometheus/metrics') do
	it { should exist }
	its('content') { should match(/node_boot_time_seconds/) }
end
describe command("rm -f metrics") do
	include_context 'check_command'
end
