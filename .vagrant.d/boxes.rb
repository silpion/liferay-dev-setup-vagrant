# vim: set ft=ruby ts=2 sw=2 et:


require 'yaml'
require 'open-uri'


REGISTRY = 'http://vagrant.silpion.de'
BOXES_YML = "#{REGISTRY}/boxes.yml"

begin
  yaml_data = open(BOXES_YML).read()
rescue
  # seems like http connect didn't pass
  # try lookup of local cache
  yaml_file = File.dirname(__FILE__) + '/boxes.yml'
  begin
    yaml_data = File.read(yaml_file)
  rescue
    exit 1
  end
end

begin
  BOXES = YAML.load(yaml_data)
rescue Psych::SyntaxError => e
  puts e.message
  puts e.backtrace.inspect
  exit 1
end
