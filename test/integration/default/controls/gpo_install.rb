# frozen_string_literal: true

file_owner = 'BUILTIN\\Administrators'
policy_dir = 'C:\\Windows\\PolicyDefinitions'
policy_revision = { 'firefox' => '1.11', 'mozilla' => '1.0' }

control 'firefox-gpo-install' do
  title 'Firefox admin templates should be installed'

  %w[firefox mozilla].each do |template|
    template_file = "#{policy_dir}\\#{template}.admx"
    lang_file = "#{policy_dir}\\en-US\\#{template}.adml"

    describe file(template_file) do
      it { should be_file }
      it { should be_owned_by file_owner }
      its('content') do
        should include(
          '<policyDefinitions revision="' + policy_revision[template] + '"'
        )
      end
    end

    describe file(lang_file) do
      it { should be_file }
      it { should be_owned_by file_owner }
    end
  end
end
