#
# Cookbook:: utility
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

[
    'RSAT-ADDS-Tools',
    'Hyper-V-Tools',
    'GPMC',
    'Web-Mgmt-Tools',
    'Web-Mgmt-Console',
    'Web-Ftp-Server',
    'Print-Server'
].each do |feature|
    dsc_resource 'Ensure Utility Server Components Installed' do
        resource :WindowsFeature
        property :Name, feature
        property :Ensure, 'Present'
    end
end

powershell_script 'Install xWebAdmin' do
    code 'Install-Module -Name xWebAdministration -SkipPublisherCheck -Force'
    only_if '!(Get-Module xWebAdministration -ListAvailable)'
  end

dsc_resource 'Ensure FTP Service is automatic and running' do
    resource :Service
    property :Name, 'FTPSVC'
    property :StartupType, 'Automatic'
    property :State, 'Running'
end

dsc_resource 'Ensure Print Service is automatic and running' do
  resource :Service
  property :Name, 'Spooler'
  property :StartupType, 'Automatic'
  property :State, 'Running'
end
