#!/bin/bash
# Note: May need conversion to Unix standard: dos2unix makedata.sh

#  Set user options here
#  ifCSV controls the writing or not of CSV files in the aggregation module
#  ifAggTrade controls whether the output SAM has trade by partner or aggregate trade
ifCSV=1
ifAggTrade=1

# We can also store arguments from bash command line in special array
args=("$@")
# Initialize flags
ifEnv=false
ifFilter=false
ifAlt=false

function usage()
{
    echo ""
    echo "Usage: ./makedata.sh baseName [-h] [-ifEnv] [-ifFilter] -[ifAlt]"
    echo ""
    echo "The makedata shell automates aggregation of the GTAP database for either the GTAP"
    echo "or Envisage models. The arguments are:"
    echo ""
    echo "baseName   Required. For example '10x10' assumes the file '10x10Map.gms' exists."
    echo "-h         Requests help on the command, i.e. repeats this."
    echo "-ifEnv     Requests an aggregation for the Envisage model. Default is a GTAP model aggregation."
    echo "-ifFilter  Invokes the filter module."
    echo "-ifAlt     Invokes the Altertax module."
    echo ""
}

if [ $# -lt 1 ]
  then
    echo ""
    echo "ERROR: Need at least one argument..."
    usage
    exit
fi

baseName="$1"
Model="GTAP"
shift

while [ "$1" != "" ]; do
    # lower case argument
    argValue="${1,,}"
    case $argValue in
        -h | --help)
            usage
            exit
            ;;
        -ifenv)
            ifEnv=true
            Model="Env"
            ;;
        -ifalt)
            ifAlt=true
            ;;
        -iffilter)
            ifFilter=true
            ;;
        *)    # Unknown option
            echo ""
            echo "ERROR: Unknown option ($argValue)..."
            usage
            exit
        ;;
    esac
    shift
done

if [ true ]; then
   echo 'Basename: ' $baseName
   echo '   ifEnv: ' $ifEnv
   echo 'ifFilter: ' $ifFilter
   echo '   ifAlt: ' $ifAlt
   echo '   Model: ' $Model
fi

#Check to make sure file exists
fileName="$baseName"
fileName+="Map.gms"
# echo $fileName
if [ ! -e $fileName ];  then
    echo ""
    echo "ERROR: File $fileName not found..."
    usage
    exit
fi

#  Create directory structure if it doesn't already exist

if [ ! -d $baseName ]; then
   mkdir $baseName
fi

if [ ! -d $baseName/agg ]; then
   mkdir $baseName/agg
fi

if [ ! -d $baseName/flt ]; then
   mkdir $baseName/flt
fi

if [ ! -d $baseName/alt ]; then
   mkdir $baseName/alt
fi

if [ ! -d $baseName/fnl ]; then
   mkdir $baseName/fnl
fi

#  Invoke the aggregation module

if [ "$ifAlt" = true ]; then
   Alt="ON"
else
   Alt="OFF"
fi

# Skip for testing purposes only
ifAgg=true
if [ "$ifAgg"  = true ]; then
   "C:/Users/dominique/OneDrive/OneDrive - purdue.edu/Gams64/gams" aggGTAP --basename=$baseName --ifAlt=$Alt --model=$Model --ifCSV=$ifCSV --ifAggTrade=$ifAggTrade -pw=150 -ps=9999
   rc=$?
   echo "AggGTAP return code: " $rc
   if [ $rc -ne 0 ]; then
      echo ""
      echo "ERROR: Aggregation module failed, check listing file (aggGTAP.lst)..."
      echo ""
      exit
   fi
fi

#  Invoke the filter module

if [ "$ifFilter" = true ]; then
   # Check to make sure we have a filter option file

   fileName="$baseName"
   fileName+="Flt.gms"
   if [ ! -e $fileName ];  then
      echo ""
      echo "ERROR: File $fileName not found..."
      usage
      exit
   fi
   # Copy non-filter files to the flt folder
   if [ -e  $baseName/agg/$baseName"Elast.gdx" ]; then
      $fileName=$baseName/agg/$baseName"Elast.gdx"
      cp -p $baseName/agg/$baseName"Elast.gdx" $baseName/flt/$baseName"Elast.gdx"
   fi
   if [ -e  $baseName/agg/$baseName"par.gdx" ]; then
      cp -p $baseName/agg/$baseName"par.gdx" $baseName/flt/$baseName"par.gdx"
   fi
   if [ -e  $baseName/agg/$baseName"Prm.gdx" ]; then
      cp -p $baseName/agg/$baseName"Prm.gdx" $baseName/flt/$baseName"Prm.gdx"
   fi
   if [ -e  $baseName/agg/$baseName"BoP.gdx" ]; then
      cp -p $baseName/agg/$baseName"BoP.gdx" $baseName/flt/$baseName"BoP.gdx"
   fi
   if [ -e  $baseName/agg/$baseName"Sat.gdx" ]; then
      cp -p $baseName/agg/$baseName"Sat.gdx" $baseName/flt/$baseName"Sat.gdx"
   fi
   if [ -e  $baseName/agg/$baseName"Scn.gdx" ]; then
      cp -p $baseName/agg/$baseName"Scn.gdx" $baseName/flt/$baseName"Scn.gdx"
   fi
   "C:/Users/dominique/OneDrive/OneDrive - purdue.edu/Gams64/gams" filter --basename=$baseName --ifCSV=$ifCSV --ifAggTrade=$ifAggTrade -pw=150 -ps=9999
   rc=$?
   echo ""
   echo "Filter return code: " $rc
   if [ $rc -ne 0 ]; then
      echo ""
      echo "ERROR: Filter module failed, check listing file (filter.lst)..."
      echo ""
      exit
   else
      echo "Check the listing (filter.lst) and log ($baseName"flt.log") files..."
      echo ""
   fi
else
   #  Copy the files from agg to flt
   cp -r -p $baseName/agg/*.gdx $baseName/flt
fi

#  Invoke the Altertax module

if [ "$ifAlt" = true ]; then
   # Check to make sure we have a Altertax option file

   fileName="$baseName"
   fileName+="Alt.gms"
   if [ ! -e $fileName ];  then
      echo ""
      echo "ERROR: File $fileName not found..."
      usage
      exit
   fi
   # Copy non-Altertax files to the Alt folder
   if [ -e  $baseName/flt/$baseName"Elast.gdx" ]; then
      $fileName=$baseName/flt/$baseName"Elast.gdx"
      cp -p $baseName/flt/$baseName"Elast.gdx" $baseName/alt/$baseName"Elast.gdx"
   fi
   if [ -e  $baseName/flt/$baseName"par.gdx" ]; then
      cp -p $baseName/flt/$baseName"par.gdx" $baseName/alt/$baseName"par.gdx"
   fi
   if [ -e  $baseName/flt/$baseName"Prm.gdx" ]; then
      cp -p $baseName/flt/$baseName"Prm.gdx" $baseName/alt/$baseName"Prm.gdx"
   fi
   if [ -e  $baseName/flt/$baseName"BoP.gdx" ]; then
      cp -p $baseName/flt/$baseName"BoP.gdx" $baseName/alt/$baseName"BoP.gdx"
   fi
   if [ -e  $baseName/flt/$baseName"Sat.gdx" ]; then
      cp -p $baseName/flt/$baseName"Sat.gdx" $baseName/alt/$baseName"Sat.gdx"
   fi
   if [ -e  $baseName/flt/$baseName"Scn.gdx" ]; then
      cp -p $baseName/flt/$baseName"Scn.gdx" $baseName/alt/$baseName"Scn.gdx"
   fi
   "C:/Users/dominique/OneDrive/OneDrive - purdue.edu/Gams64/gams" Altertax --basename=$baseName --ifCSV=$ifCSV --niter=1 -idir=GTAPModel -pw=150 -ps=9999
   rc=$?
   echo ""
   echo "Altertax return code: " $rc
   if [ $rc -ne 0 ]; then
      echo ""
      echo "ERROR: Altertax module failed, check listing file (altertax.lst)..."
      echo ""
      exit
   else
      echo "Check the listing (Altertax.lst) file..."
      echo ""
   fi
else
   #  Copy the files from flt to alt
   cp -r -p $baseName/flt/*.gdx $baseName/agg
fi

#  Final processing
#  Copy all files from Alt to Fnl
cp -r -p $baseName/alt/$baseName*.gdx $baseName/fnl

echo ""
echo "Successful processing..."
echo "Post-processing files are in $baseName/fnl"
