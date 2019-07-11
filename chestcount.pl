#!/usr/bin/perl -T -w

$stacksize=64;
$singlechest=27;
$doublechest=$singlechest*2; 

while(<>){
  /^(.*\w)\s+(\d+)$/;
  $item      =$1; 
  $fullcount = $2;

  $dc     = int(  $fullcount / ($doublechest*$stacksize));
  $sc     = int(( $fullcount - $stacksize * ( $dc*$doublechest ) ) / ($singlechest*$stacksize));
  $stacks = int(( $fullcount - $stacksize * ( $dc*$doublechest + $sc*$singlechest ) ) /  $stacksize );
  $blocks =       $fullcount - $stacksize * ( $dc*$doublechest + $sc*$singlechest + $stacks );

  print "($item) ($fullcount) [[$dc]] [$sc] {$stacks} <$blocks>\n"
}
