# # encoding: utf-8

# Inspec test for recipe install-py-rb-go::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Check command
RSpec.shared_context 'check_command' do
	its('stderr') { should eq '' }
	its('exit_status') { should eq 0 }
end

# check nginx site
#describe http('http://localhost:8080/') do
#	its('status') { should cmp 200 }
#	its('body') { should include 'Welcome to nginx!' }
#end

# check prometheus site
#describe http('http://localhost:8080/prometheus/metrics', max_redirects: 0) do
describe http('http://localhost:8080/metrics', max_redirects: 0) do
	its('status') { should cmp 200 }
	its('body') { should include 'go_gc_duration_seconds' }
	# its('body') { should include 'prometheus_http_response_size_bytes' }
end
# describe http('http://localhost:8080/prometheus/targets') do
describe http('http://localhost:8080/targets') do
	its('status') { should cmp 200 }
	its('body') { should include 'http://localhost:9090/metrics' }
	its('body') { should include 'http://node_exporter:9100/metrics' }
end

# check grafana site
# describe http('http://localhost:8080/grafana/login') do
describe http('http://localhost:8081/login') do
	its('status') { should cmp 200 }
end

# check node exporter
describe http('http://localhost:9100/metrics') do
	its('status') { should cmp 200 }
	its('body') { should match(/node_boot_time_seconds/) }
end
