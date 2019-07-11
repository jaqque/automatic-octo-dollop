#!/usr/bin/ruby

def containers_in_count(total, size)
  return total.to_i/size.to_i, total.to_i%size.to_i
end

def get_stack_size(item)
  return 0 if item == "Bedrock" # can't mine bedrock :D
  return 1 if item == "Water" # unstackable
  return 1 if item == "Lava"  # unstackable
  64 # default stack size
end

def inventory_of_sc
  27
end

def shulker_capacity
  inventory_of_sc * $stack_size
end

def sc_of_shulker_capacity
  inventory_of_sc * shulker_capacity
end

def dc_of_shulker_capacity
  2 * sc_of_shulker_capacity # "2" means "double"!
end

def commify(number)
  # cut/paste from https://codereview.stackexchange.com/questions/28054/separate-numbers-with-commas
  number.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
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

ARGF.each do |l|
  *name, count = l.split("\s")
  name=name.join(' ')

  $stack_size = get_stack_size(name)
  next if $stack_size == 0 # we don't care -- NEXT!

  dc, remainder = containers_in_count( count, dc_of_shulker_capacity)
  sc, remainder = containers_in_count( remainder, sc_of_shulker_capacity)
  shulker, remainder = containers_in_count( remainder, shulker_capacity)
  stacks, blocks = containers_in_count( remainder, $stack_size)

  printf format,
    name,
    ':',
    commify(dc),
    sc,
    shulker,
    stacks,
    blocks
end
