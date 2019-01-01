if(%ifCSV%,
   put csv ;

*  Production

   loop((r,a),
      loop(i$(edf%2(i,a,r) + emf%2(i,a,r)),
         put "%1", "NRG", r.tl, i.tl, a.tl, (edf%2(i,a,r) + emf%2(i,a,r)) / ;
      ) ;
      loop(i$(mdf%2(i,a,r) + mmf%2(i,a,r)),
         put "%1", "CO2", r.tl, i.tl, a.tl, (mdf%2(i,a,r) + mmf%2(i,a,r)) / ;
      ) ;

      $$iftheni.nco2a "%NCO2%" == "ON"
         loop(nco2,
            loop(i$(NC_TRAD%2(NCO2, i, a, r)),
               put "%1", nco2.tl, r.tl, i.tl, a.tl, (NC_TRAD%2(NCO2, i, a, r)) / ;
            ) ;
            loop(fp$(NC_ENDW%2(NCO2, fp, a, r)),
               put "%1", nco2.tl, r.tl, fp.tl, a.tl, (NC_ENDW%2(NCO2, fp, a, r)) / ;
            ) ;
            put$(NC_QO%2(NCO2, a, r)) "%1", nco2.tl, r.tl, "qo", a.tl, (NC_QO%2(NCO2, a, r)) / ;

*           Output same in CO2eq

            loop(mapco2eq(emn, nco2eq),
               loop(i$(NC_TRAD%2(emn, i, a, r)),
                  put "%1", nco2eq.tl, r.tl, i.tl, a.tl, (NC_TRAD_Ceq%2(emn, i, a, r)) / ;
               ) ;
               loop(fp$(NC_ENDW%2(emn, fp, a, r)),
                  put "%1", nco2eq.tl, r.tl, fp.tl, a.tl, (NC_ENDW_Ceq%2(emn, fp, a, r)) / ;
               ) ;
               put$(NC_QO%2(emn, a, r)) "%1", nco2eq.tl, r.tl, "qo", a.tl, (NC_QO_Ceq%2(emn, a, r)) / ;
            ) ;
         ) ;
      $$endif.nco2a
   ) ;

*  Final demand

   loop(r,
      loop(i$(edp%2(i,r) + emp%2(i,r)),
         put "%1", "NRG", r.tl, i.tl, "PRIV", (edp%2(i,r) + emp%2(i,r)) / ;
      ) ;
      loop(i$(mdp%2(i,r) + mmp%2(i,r)),
         put "%1", "CO2", r.tl, i.tl, "PRIV", (mdp%2(i,r) + mmp%2(i,r)) / ;
      ) ;

      $$iftheni.nco2b "%NCO2%" == "ON"
         loop(nco2,
            loop(i$NC_HH%2(NCO2, i, r),
               put "%1", nco2.tl, r.tl, i.tl, "PRIV", (NC_HH%2(NCO2, i, r)) / ;
            ) ;

*           Output same in CO2eq

            loop(mapco2eq(nco2,nco2eq),
               loop(i$NC_HH%2(NCO2, i, r),
                  put "%1", nco2eq.tl, r.tl, i.tl, "PRIV", (NC_HH_Ceq%2(NCO2, i, r)) / ;
               ) ;
            ) ;
         ) ;
      $$endif.nco2b

      loop(i$(edg%2(i,r) + emg%2(i,r)),
         put "%1", "NRG", r.tl, i.tl, "GOV", (edg%2(i,r) + emg%2(i,r)) / ;
      ) ;
      loop(i$(mdg%2(i,r) + mmg%2(i,r)),
         put "%1", "CO2", r.tl, i.tl, "GOV", (mdg%2(i,r) + mmg%2(i,r)) / ;
      ) ;
      loop(i$(edi%2(i,r) + emi%2(i,r)),
         put "%1", "NRG", r.tl, i.tl, "INV", (edi%2(i,r) + emi%2(i,r)) / ;
      ) ;
      loop(i$(mdi%2(i,r) + mmi%2(i,r)),
         put "%1", "CO2", r.tl, i.tl, "INV", (mdi%2(i,r) + mmi%2(i,r)) / ;
      ) ;

   ) ;

*  Exports

   if(ifAggTrade,
      loop((r,i)$(sum(rp, EXIDAG%2(i,r,rp))),
         put "%1", "NRG", r.tl, i.tl, "BOP",  (sum(rp, EXIDAG%2(i,r,rp))) / ;
      ) ;
   else
      loop((r,i,rp)$(EXIDAG%2(i,r,rp)),
         put "%1", "NRG", r.tl, i.tl, rp.tl,  EXIDAG%2(i,r,rp) / ;
      ) ;
   ) ;
) ;
