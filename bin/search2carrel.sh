#!/usr/bin/env bash

# search2carrel.sh - given the name of a study carrel and a Solr query, initialize the carrel

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# May 16, 2020 - first investigations; do one small thing, and do it well


# configure
SEARCH='./bin/search.pl'
CARRELINITIALIZE='./bin/carrel-initialize.sh'

# sanity check
if [[ -z $1 || -z $2 ]]; then
	echo "Usage: $0 <carrel> <query>" >&2
	exit
fi

# get input
NAME=$1
QUERY=$2

# search the index and get an SQL WHERE clause
WHERE=$( $SEARCH sql "$QUERY" )

# pass the clause off to initialize and done
$CARRELINITIALIZE $NAME "$WHERE"
exit
