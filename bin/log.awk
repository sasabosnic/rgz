BEGIN {
   FS="\""
   OFS=""
   ORS="\n\n"
   print "a2 Combined Log Format"
}
 
{ 
   print $3, 
   "\nIP: ", $1, 
   "\nUA: ",  $9, 
   "\nHTTP Request: ", $5, 
   "\nHTTP Status Code: ", substr($6,2,4), 
   "\nReferal URL: ", $7 
}

END {
   OFS=":"
   print "\nLog File Entires", NR
}
