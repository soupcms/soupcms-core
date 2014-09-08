require 'bundler'
Bundler.setup

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'mongo'
require 'json'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :seed do
  conn = Mongo::MongoClient.new
  db = conn.db('soupcms-test')
  # clean up database
  puts 'Cleaning up the database...'
  db.collection_names.each { |name|
    next if name.match(/^system/)
    db[name].remove
  }
  # import jsons
  Dir.glob('seed/**/*.json').each do |file|
    puts "Importing file... #{file}"
    file =  File.new(file)
    model = file.path.split('/')[1]
    document_hash = JSON.parse(file.read)
    document = ParseFileContent.new(File.dirname(file)).parse(document_hash)
    db[model].insert(document)
  end
  conn.close
end


class ParseFileContent

  def initialize(path)
    @path = path
  end

  def parse(document)
    if document.kind_of?(Array)
      document.collect { |doc| parse_for_file(doc) }
    elsif document.kind_of?(Hash)
      parse_for_file(document)
    end
  end

  def parse_for_file(document)
    document.each do |key, value|
      if value.kind_of?(Array)
        document[key] = value.collect { |item| item.kind_of?(Hash) ? parse_for_file(item) : item }
      elsif value.kind_of?(Hash)
        document[key] = parse_for_file(value)
      elsif value.kind_of?(String) && value.match(/^\$file:/)
        document[key] = File.read(File.join(@path,value.match(/\$file:([\w\.\-]*)/).captures[0]))
      end
    end
    @document = document
  end

end