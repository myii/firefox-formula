# frozen_string_literal: true

# Overide by OS
package_name = 'Mozilla Firefox'

control 'firefox-package-install' do
  title 'Mozilla Firefox should be installed'

  describe package(package_name) do
    it { should be_installed }
    its('version') { should eq '68.0' }
  end
end
