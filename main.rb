puts 'Oh hey i read the schematica-materials.txt file directly'
puts 'I hope it is a part of this repo, otherwise bad things may happen'
puts
puts 'Bad Things.'
puts

ARGV.push('schematica-materials.txt')
eval File.read('shulkerthingbutthistimeinruby.rb')
