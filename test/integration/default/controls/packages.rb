# frozen_string_literal: true

package_name = 'Mozilla Firefox'
desktop_shortcut = 'C:\\Users\\Public\\Desktop\\Firefox.lnk'

control 'firefox-package-install' do
  title 'Mozilla Firefox should be installed'

  describe package(package_name) do
    it { should be_installed }
    its('version') { should eq '68.0' }
  end

  describe file(desktop_shortcut) do
    it { should_not exist }
  end
end
