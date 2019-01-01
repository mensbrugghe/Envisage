set baseName=10x10
set oDir=z:\Output\Env10\%baseName%
gams runSim --simName=%1 --BauName=%2 --simType=%3 --ifCal=%4 --baseName=%baseName% --startName=%5 --startYear=%6 --odir=%oDir% -idir=..\model -scrdir=%oDir% -ps=9999 -pw=150 -errmsg=1
