# frozen_string_literal: true

# Overide by OS
package_name = 'Mozilla Firefox'

control 'firefox package' do
  title 'should be installed'

  describe package(package_name) do
    it { should be_installed }
  end
end
