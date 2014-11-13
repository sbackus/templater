#!/usr/bin/env ruby
require 'json'
require './nodes.rb'
require './compiler.rb'

class Templater

  def initialize(template)
    @template = template
    @root = Compiler.new(template).compile
  end

	def render(json)
		@root.render json
	end
end

def print_usage
	puts "usage:"
	puts "templater template.panoramatemplate data.json output.html"
end

def render_template(template_path, json_path, output_path)
	template = File.open(template_path).read
	json = JSON.parse(File.open(json_path).read)
	output = Templater.new(template).render json
	File.open(output_path, 'w') { |file| file.write output }
end

template_path = ARGV[0]
json_path = ARGV[1]
output_path = ARGV[2]

if template_path.nil? || json_path.nil? || output_path.nil?
	print_usage
else
	render_template(template_path, json_path, output_path)
end

