#!/usr/bin/ruby
#
# Lasse Osterild
#

require 'net/https'
require 'rexml/document'

obs     =   "127.0.0.1"
sysUser = "system-username"
sysPass = "password"

# Build the URI
uri = URI.parse('https://' + obs);

# Request the page.
begin
  request = Net::HTTP.new(uri.host, uri.port)
  request.use_ssl = true
  request.verify_mode = OpenSSL::SSL::VERIFY_NONE

  response = request.get('/obs/api/GetReplicationMode.do?SysUser=' + sysUser + '&SysPwd=' + sysPass);
  if response.code != "200"
    raise
  end
rescue
  puts "-3"
  exit 1
end

begin
  xmlDoc = REXML::Document.new response.body
rescue
  puts "-4"
  exit 1
end

case xmlDoc.root.attributes["Mode"]
  when "DISABLED" then  puts "0"	# "DISABLED"
  when "LOGGING"  then  puts "1"	# "LOGGING"
  when "UNSYNC"   then  puts "2"	# "UNSYNC"
  when "SYNC"     then  puts "3"	# "SYNC"
  when nil        then  puts "-1"	# "Error"
  else                  puts "-2"	# #Error"
end
