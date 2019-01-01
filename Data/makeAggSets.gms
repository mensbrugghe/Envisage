*  Save and then re-read 'final' labels

file asets / tmpSets.gms / ;
put asets ;

put '$onempty' / / ;
put 'set actf "Modeled activities" /' / ;
* Use the model aggregation
loop(actf,
   strlen = card(actf.tl) ;
   put '   ', actf.tl:<strlen, '':(maxstrlen-strlen), '     "', actf.te(actf), '"' / ;
) ;
put '/ ;' / / ;

put 'set mapact(a,actf) "Activity mapping" /' / ;
loop(actf,
   strlen = card(actf.tl) ;
   put '   ', actf.tl:<strlen, '-a', '.', actf.tl / ;
) ;
put '/ ;' / / ;

put 'set commf "Modeled commodities" /' / ;
* Use the model aggregation
loop(commf,
   strlen = card(commf.tl) ;
   put '   ', commf.tl:<strlen, '':(maxstrlen-strlen), '     "', commf.te(commf), '"' / ;
) ;
put '/ ;' / / ;

put 'set mapcomm(i,commf) "Commodity mapping" /' / ;
loop(commf,
   strlen = card(commf.tl) ;
   put '   ', commf.tl:<strlen, '-c', '.', commf.tl / ;
) ;
put '/ ;' / / ;

put 'set elycf(commf) "Electricity commodities" /' / ;
loop(commf$elyc(commf),
   strlen = card(commf.tl) ;
   put '   ', commf.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', commf.te(commf), '"' / ;
) ;
put '/ ;' / / ;

put 'set kf "Household commodities" /' / ;
loop(k,
   strlen = card(k.tl) ;
   put '   ', k.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', k.te(k), '"' / ;
) ;
put '/ ;' / / ;

put 'set mapkcomm(k,kf) "Household commodity mapping" /' / ;
loop(k,
   strlen = card(k.tl) ;
   put '   ', k.tl:<strlen, '-k', '.', k.tl / ;
) ;
put '/ ;' / / ;

put '$offempty' ;

putclose asets ;
