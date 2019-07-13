
eval File.read("calculator.rb") #Get their total

print "Do you wish to store these items? (yes or no) "
store = gets.chomp().downcase

ARGV.push('schematica-materials.txt')
eval File.read("storage.rb") if store == "yes"

#DOWNLOADED VERSION ONLY. Do not use in repl or browser. (Note out the ARGV below this section if downloading.)
# print "Please input the name of the file I am reading from. "
# file = gets.chomp().downcase() + ".txt"
# ARGV.push(file)