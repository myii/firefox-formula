# frozen_string_literal: true

control 'firefox-gpo-config' do
  title 'Firefox policies should be applied'

  describe registry_key('HKLM\Software\Policies\Mozilla\Firefox') do
    its('DisableAppUpdate') { should eq 1 }
    its('DisablePrivateBrowsing') { should eq 1 }
  end
end
