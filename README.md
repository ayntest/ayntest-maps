# ayntest-maps

A collection of scripts for processing [our minetest map](http://maps.ayntest.net/) for [leafletjs](http://leafletjs.com/).  
The purpose of these scripts is to take a very large, square map image, crop and scale it, so that it can be displayed by leaflet js.  
At the moment, it makes a lot of hard-coded assumptions about the input map image and the leafletjs configuration. Until it gets tidied up, *use with caution, or only as a reference*.

The exact command used for `minetestmapper` to produce the fullsize 9600x9600 map is the following:

```
./minetestmapper --backend leveldb --min-y -100 --max-y 100 --geometry -4800:-4800+9664+9600 --input ~/worlds/libertyland --output ~/map.png --drawalpha 2> unknown-nodes.log
```
