#!/bin/bash

set -o nounset

FULL_MAP="$1"
RENAME_SCRIPT="$PWD/rename_tiles.py"
TMPDIR="/tmp/tiles/"
WEBDIR="/var/www/maps.ayntest.net/tiles/"

TILE_SIZE=344


# backup current map
cp "$FULL_MAP" "map-$(date +%s).png"

echo 'setting up temporary directory'
[ -d $TMPDIR ] && rm -r $TMPDIR
mkdir $TMPDIR
mkdir $TMPDIR/24
mkdir $TMPDIR/23
mkdir $TMPDIR/22

convert -verbose -crop "${TILE_SIZE}x$TILE_SIZE" +repage "$FULL_MAP"  $TMPDIR/24/tiles_%d.png
convert -verbose -scale 50% "$FULL_MAP" $TMPDIR/map23.png
convert -verbose -crop "${TILE_SIZE}x$TILE_SIZE" +repage $TMPDIR/map23.png  $TMPDIR/23/tiles_%d.png
convert -verbose -scale 25% "$FULL_MAP" $TMPDIR/map22.png
convert -verbose -crop "${TILE_SIZE}x$TILE_SIZE" +repage $TMPDIR/map22.png  $TMPDIR/22/tiles_%d.png

$RENAME_SCRIPT 8256 $TILE_SIZE $TMPDIR/24
$RENAME_SCRIPT 4128 $TILE_SIZE $TMPDIR/23
$RENAME_SCRIPT 2064 $TILE_SIZE $TMPDIR/22

rsync -avh --progress $TMPDIR/ $WEBDIR
rm -r $TMPDIR
