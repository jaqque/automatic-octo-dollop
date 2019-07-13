
ar = [] #Globalize the placeholder for the mats

# Read the files into prep for tags that will be later assessed and then put with a price.
File.open('schematica-materials.txt').each {|line| ar.push(line.chomp().split(' '))}

# Globalize
tags = []
count = []
# Remove the number at the end, store the number, then flatten it into strings.
ar.each do |f|
  count.push(f.pop().to_i) #Remove the number and store it for later
  if f.length() >= 2
    tags.push(f.join(" ")) #Flatten 2 or more length words into 1 string.
  else
    tags.push(f) #Otherwise, it's fine.
  end
end

tags.flatten!() #Squish nested arrays of 1 long mats

# Check a set of items to delete as needed. (Borrowed from https://repl.it/@jaqque/VioletredFailingBacktick) *thanks jaq*
def check(item)
  return 1 if item == "Bedrock" # can't mine bedrock :D
  return 1 if item == "Spawner" # can't save a spawner
  return 2 if item == "Chest"   # Loot
  return 2 if item == "Rail"    # possible loot
end

#Run through the list, removing null items and checking for loot.
tags.each do |j|
  if check(j) == 1 #If null, remove from count and tags.
    count.delete_at(tags.find_index(j))
    tags.delete_at(tags.find_index(j))
  elsif check(j) == 2 #If special, then check for loot.
    print "Hey! Check the chunk for loot. A #{j.downcase()} was found. (type yes, if there's loot) "
    loot = gets.chomp().downcase()
    if loot == "yes" #If loot is found, add the items.
      #If rail, then add the minecart and chest
      if j == "Rail"
        #Should've thought of this sooner- if there's a dungeon too... Or you've already found a cart (unlikely but y'know everything's gotta get checked)
        if tags.include?("Chest")
          if tags.include?("Minecart")
            count[tags.find_index("Minecart")] += 1
            count[tags.find_index("Chest")] += 1
          else
            tags.push("Minecart")
            count.push(1)
            count[tags.find_index("Chest")] += 1
          end
        else
          tags.push("Minecart")
          tags.push("Chest")
          2.times {count.push(1)} #(Adding 1 to the count for both items)
        end
      end
      #Ask how many items there are, then iterate that many times, asking for the item and count each time.
      print "Ok. How many individual items do you have? "
      loot_count = gets.chomp().to_i
      loot_count.times do |f|
        print "Name of the item? (cap the 1st letter) "
        tags.push(gets.chomp())
        print "Count? "
        count.push(gets.chomp().to_i)
      end
    end
    puts "Thank you!" #Always be kind for bothering the operator!
  end
end

#Get the prices (do the same conncept as above)
pr = []
File.open('prices.txt').each {|line| pr.push(line.chomp().split(' '))}

prices = {}
pr.each do |a|
  a_c = a.pop().to_i
  if a.length() >= 2
    prices.store(a.join(" "), a_c)
  else
    prices.store(a[0], a_c)
  end
end

#Now match tag to price
price_arr = [] #Globalize
edit = false #If something needs to be added. So I don't spam
tags.each do |t|
  if prices.member?(t)              # If hash has
    price_arr.push(prices.fetch(t)) # Tag, then value
  else 
    print "Hey. This item doesn't exist. Please give me a price for #{t.downcase()}. "
    price_arr.push(gets.chomp().to_i)
    edit = true if edit == false
  end
end

total = 0
index = 0 #to use
price_arr.each do |p|
  total += (p * count[index]) 
  index += 1 #Move index up
end

#Thanks again, jaq :)
def commify(number)
  # cut/paste from https://codereview.stackexchange.com/questions/28054/separate-numbers-with-commas
  number.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
end

puts "Thank you. Don't forget to edit prices.txt with the new prices." if edit == true #If the player added a price, then they need to be reminded to add the prices.
puts "The user has earned a total of #{commify(total)} based on the file provided, and any loot that they found. Thank you!"