#!/usr/bin/env ruby
# encoding: ASCII-8BIT

module Generators

  PROJ_ROOT = File.expand_path('../..', __FILE__)
  GENERATOR_DIR = File.expand_path('lib/generators', PROJ_ROOT)


  def self.list_generators
    Dir.glob("#{GENERATOR_DIR}/*.yaml").map do |file|
      File.basename(file).split('.').first
    end
  end

  # Input: the name of a generator
  # Output: [description]
  #
  def self.get_generator_description(name)
    file = File.expand_path("#{name}.yaml", GENERATOR_DIR)
    fail "#{file} does not exist" if !File.exist? file
    data = YAML.load(File.read(file))
    [data.delete('summary')]
  end

  def self.run(name)
    cmd = File.expand_path("#{name}.rb", GENERATOR_DIR)
    exec(cmd)
  end

end
