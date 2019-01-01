if(%ifCSV%,
   put csv ;

*  Production

   loop((r,a0),
      loop(i0$(edf%2(i0,a0,r) + emf%2(i0,a0,r)),
         put "NRG", r.tl, i0.tl, a0.tl, %1:1:0, (edf%2(i0,a0,r) + emf%2(i0,a0,r)) / ;
      ) ;
      loop(i0$(mdf%2(i0,a0,r) + mmf%2(i0,a0,r)),
         put "CO2", r.tl, i0.tl, a0.tl, %1:1:0, (mdf%2(i0,a0,r) + mmf%2(i0,a0,r)) / ;
      ) ;

      $$iftheni.nco2a "%NCO2%" == "ON"
         loop(nco2,
            loop(i0$(NC_TRAD%2(NCO2, i0, a0, r)),
               put nco2.tl, r.tl, i0.tl, a0.tl, %1:1:0, (NC_TRAD%2(NCO2, i0, a0, r)) / ;
            ) ;
            loop(fp$(NC_ENDW%2(NCO2, fp, a0, r)),
               put nco2.tl, r.tl, fp.tl, a0.tl, %1:1:0, (NC_ENDW%2(NCO2, fp, a0, r)) / ;
            ) ;
            put$(NC_QO%2(NCO2, a0, r)) nco2.tl, r.tl, "qo", a0.tl, %1:1:0, (NC_QO%2(NCO2, a0, r)) / ;

*           Output same in CO2eq

            loop(mapco2eq(nco2,nco2eq),
               loop(i0$(NC_TRAD%2(NCO2, i0, a0, r)),
                  put nco2eq.tl, r.tl, i0.tl, a0.tl, %1:1:0, (NC_TRAD_Ceq%2(NCO2, i0, a0, r)) / ;
               ) ;
               loop(fp$(NC_ENDW%2(NCO2, fp, a0, r)),
                  put nco2eq.tl, r.tl, fp.tl, a0.tl, %1:1:0, (NC_ENDW_Ceq%2(NCO2, fp, a0, r)) / ;
               ) ;
               put$(NC_QO%2(NCO2, a0, r)) nco2eq.tl, r.tl, "qo", a0.tl, %1:1:0, (NC_QO_Ceq%2(NCO2, a0, r)) / ;
            ) ;
         ) ;
      $$endif.nco2a
   ) ;

*  Final demand

   loop(r,
      loop(i0$(edp%2(i0,r) + emp%2(i0,r)),
         put "NRG", r.tl, i0.tl, "PRIV", %1:1:0, (edp%2(i0,r) + emp%2(i0,r)) / ;
      ) ;
      loop(i0$(mdp%2(i0,r) + mmp%2(i0,r)),
         put "CO2", r.tl, i0.tl, "PRIV", %1:1:0, (mdp%2(i0,r) + mmp%2(i0,r)) / ;
      ) ;

      $$iftheni.nco2b "%NCO2%" == "ON"
         loop(nco2,
            loop(i0$NC_HH%2(NCO2, i0, r),
               put nco2.tl, r.tl, i0.tl, "PRIV", %1:1:0, (NC_HH%2(NCO2, i0, r)) / ;
            ) ;

*           Output same in CO2eq

            loop(mapco2eq(nco2,nco2eq),
               loop(i0$NC_HH%2(NCO2, i0, r),
                  put nco2eq.tl, r.tl, i0.tl, "PRIV", %1:1:0, (NC_HH_Ceq%2(NCO2, i0, r)) / ;
               ) ;
            ) ;
         ) ;
      $$endif.nco2b

      loop(i0$(edg%2(i0,r) + emg%2(i0,r)),
         put "NRG", r.tl, i0.tl, "GOV", %1:1:0, (edg%2(i0,r) + emg%2(i0,r)) / ;
      ) ;
      loop(i0$(mdg%2(i0,r) + mmg%2(i0,r)),
         put "CO2", r.tl, i0.tl, "GOV", %1:1:0, (mdg%2(i0,r) + mmg%2(i0,r)) / ;
      ) ;
      loop(i0$(edi%2(i0,r) + emi%2(i0,r)),
         put "NRG", r.tl, i0.tl, "INV", %1:1:0, (edi%2(i0,r) + emi%2(i0,r)) / ;
      ) ;
      loop(i0$(mdi%2(i0,r) + mmi%2(i0,r)),
         put "CO2", r.tl, i0.tl, "INV", %1:1:0, (mdi%2(i0,r) + mmi%2(i0,r)) / ;
      ) ;

   ) ;

*  Exports

   loop((r,i0,rp)$(EXIDAG%2(i0,r,rp)),
      put "NRG", r.tl, i0.tl, rp.tl, %1:1:0,  EXIDAG%2(i0,r,rp) / ;
   ) ;
) ;
