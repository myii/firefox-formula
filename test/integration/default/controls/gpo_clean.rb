# frozen_string_literal: true

policy_dir = 'C:\\Windows\\PolicyDefinitions'

control 'firefox-gpo-clean' do
  title 'Firefox admin templates should NOT be installed'

  %w[firefox mozilla].each do |template|
    template_file = "#{policy_dir}\\#{template}.admx"
    lang_file = "#{policy_dir}\\en-US\\#{template}.adml"

    describe file(template_file) do
      it { should_not exist }
    end

    describe file(lang_file) do
      it { should_not exist }
    end
  end
end
