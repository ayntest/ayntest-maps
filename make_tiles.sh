#!/bin/bash

set -o nounset

FULL_MAP="$1"
RENAME_SCRIPT="$PWD/rename_tiles.py"
TMPDIR="/tmp/tiles/"
WEBDIR="/var/www/maps.ayntest.net/tiles/"

TILE_SIZE=200

BACKUPFILE="map-$(date +%s).png"


# backup current map
echo "creating $BACKUPFILE backup"
cp "$FULL_MAP" "$BACKUPFILE"

echo 'setting up temporary directory'
[ -d $TMPDIR ] && rm -r $TMPDIR
mkdir $TMPDIR
mkdir $TMPDIR/24
mkdir $TMPDIR/23
mkdir $TMPDIR/22

echo 'starting conversions'
convert -verbose -crop "${TILE_SIZE}x$TILE_SIZE" +repage "$FULL_MAP"  $TMPDIR/24/tiles_%d.png
convert -verbose -scale 50% "$FULL_MAP" $TMPDIR/map23.png
convert -verbose -crop "${TILE_SIZE}x$TILE_SIZE" +repage $TMPDIR/map23.png  $TMPDIR/23/tiles_%d.png
convert -verbose -scale 25% "$FULL_MAP" $TMPDIR/map22.png
convert -verbose -crop "${TILE_SIZE}x$TILE_SIZE" +repage $TMPDIR/map22.png  $TMPDIR/22/tiles_%d.png

echo 'renaming tiles'
$RENAME_SCRIPT 9600 $TILE_SIZE $TMPDIR/24
$RENAME_SCRIPT 4800 $TILE_SIZE $TMPDIR/23
$RENAME_SCRIPT 2400 $TILE_SIZE $TMPDIR/22

echo 'copying to webdir'
rsync -avh --progress $TMPDIR/ $WEBDIR
rm -r $TMPDIR
