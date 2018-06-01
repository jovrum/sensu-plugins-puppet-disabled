#! /usr/bin/env ruby
# encoding: UTF-8

# check-puppet-disabled
#
# DESCRIPTION:
# Check for disabled puppet agent
#
# OUTPUT:
#   plain text
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
#
# NOTES:
#

require 'sensu-plugin/check/cli'
require 'json'

class CheckPuppetDisabled < Sensu::Plugin::Check::CLI
  option :lockfile,
         short: '-l PATH',
         long: '--lockfile PATH',
         description: 'path to puppet agent disable lockfile',
         default: '/etc/puppetlabs/puppet/agent_disabled.lock'

  def run
    lockfile_path = config[:lockfile]
    if File.exist?(lockfile_path)
      reason = JSON.parse(File.read(lockfile_path))['disabled_message']
      warning("puppet agent is disabled: #{reason}")
    else
      ok
    end
  end
end
