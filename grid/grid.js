// this scripts outputs a JSON structure. Specifically, a list of lists, with one item
// for every item in the selection.
// The list item contains the bounding box, and the contenst of the textframe
// or the filename for a placed item
// It's barbaric, but it's a proof of concept
// The output of this script can be fed into grid.pl, which assigns items to a grid
// based on their approximate location

// what's really cool about this script is that it uses an external library - underscore
// to ease a lot of the heavy work. These ones work too 
// #include "md5.js";
// #include "color.js";       // works too
// #include "handlebars.js";  // works
// #include "moment.js";      // works



#target illustrator
#include "underscore.js";  // works perfectly
#include "json2.js"

var s = app.activeDocument.selection;
var rows = {}
var cols = {}

var output = [];

_.each(s, function(i) {
    var b = i.geometricBounds;
    // $.writeln( md5("value") );
    
    b.push(i.name, i.typename);
    if (i.typename == "PlacedItem") {
	b.push(i.file.fullName);
    } else if (i.typename == "TextFrame") {
	b.push(i.contents);
    }
    
    output.push(b);
});

// output.toSource()
JSON.stringify(output)
