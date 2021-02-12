#!/bin/bash
year=YEAR
product=cbp
PRODUCT=$(echo $product | tr [a-z] [A-Z])
#baseurl=ftp://ftp.census.gov/econ${year}/CBP_CSV/
baseurl=https://www2.census.gov/programs-surveys/cbp/datasets/
if [[ -z $1 ]]
then
cat << EOF
 $0 year
 will download $PRODUCT data for the relevant year.

 Source URL: $(cat ../doc/SRC.txt)
 (internally: $baseurl )
EOF
exit 2
fi

year=$1
logfile=$(pwd)/$0.$(date +%F).log
  let arg=${year}-1900
  [[ $arg -gt 99 ]] && let arg-=100
  [[ $arg -le 9 ]] && arg=0$arg
  echo "Getting CBP data for $year ($arg)"
  [ -d ../raw/ ] || mkdir ../raw
  cd ../raw/
  # configure the full URL
      fullurl=${baseurl}/${year}/
    echo "Using $fullurl as base" 
  # first we download the CBP files
  for type in co st us msa 
  do
    file=${product}${arg}$type.zip
    if [[ -f $file ]]
    then
      echo "Already have file $file"
    else
      echo "Downloading $file"
      wget  -a $logfile  $fullurl/$file
      if [[ $? != 0 ]]
      then
        file=${product}${arg}$type.txt
        echo "... trying $file"
        wget  -a $logfile  $fullurl/$file
      fi
    fi
  done
