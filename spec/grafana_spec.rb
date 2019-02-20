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
describe file('/var/lib/grafana/grafana.db') do
	it { should exist }
end

# check prometheus site
describe http('http://prometheus:9090/metrics') do
	its('status') { should cmp 200 }
	its('body') { should include 'go_gc_duration_seconds' }
	# its('body') { should include 'prometheus_http_response_size_bytes' }
end
