
#Get the capacity for a SC and DC dependent on if stackable
def shulker_capacity(stack) ; (stack * 27) end
def sc_capacity(shulker) ; (shulker * 27) end
def dc_capacity(sc) ; (sc * 2) end
def magic(stack)
  s = shulker_capacity(stack)
  c = sc_capacity(s)
  d = dc_capacity(c)
  return [d, c, s]
end

def div_mod(a, b) ; [a / b, a % b] end # simplify

#See if it's stackable...
def get_stack_size(item)
  return 0 if item == "Bedrock" # can't mine bedrock :D
  return 1 if item == "Water Bucket" # unstackable
  return 1 if item == "Lava Bucket"  # unstackable
  64 # default stack size
end

format= "%20s%c  %6s %3s %3s %3s %3s\n"
printf format,
  '',
  ' ',
  'DCs',
  'SCs',
  'Shk',
  'Stc',
  'Blk'

ARGF.each do |l| # L = readline() that I'm used to
  fluff = l.chomp().split(' ') #Ok, that breaks off the whitespace.. (I'm using it so much)
  count = fluff.pop().to_i # Get the # off...
  tag = fluff.join(" ") # Now concat words together...
  stack = get_stack_size(tag) # Check if stackable...

  next if stack == 0

  dc_volume, sc_volume, shulker_volume = magic(stack) #nums
 
  #Needs to do the maths... I need DC, then SC, then shulker, then stack. (Thank you jaq.)
  dc, remainder = div_mod(count, dc_volume)
  sc, remainder = div_mod( remainder, sc_volume)
  shulker, remainder = div_mod( remainder, shulker_volume)
  stacks, blocks = div_mod( remainder, stack)
  
  if stack == 64
    printf format,
      tag,
      ':',
      dc,
      sc,
      shulker,
      stacks,
      blocks
  else 
    printf format,
      tag,
      ':',
      dc,
      sc,
      shulker,
      stacks,
      "N/A"
  end
end