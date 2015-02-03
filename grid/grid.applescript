set js to "
#target illustrator
#include \"/Users/cesansim/Desktop/laterals/underscore.js\"; 
#include \"/Users/cesansim/Desktop/laterals/json2.js\"; 

var s = app.activeDocument.selection;
var rows = {}
var cols = {}

var output = [];

_.each(s, function(i) {
    var b = i.geometricBounds;    
    b.push(i.name, i.typename);
    if (i.typename == \"PlacedItem\") {
	b.push(i.file.fullName);
    } else if (i.typename == \"TextFrame\") {
	b.push(i.contents);
    }
    
    output.push(b);
});

JSON.stringify(output)
"

tell application "Adobe Illustrator"
     do JavaScript js
end tell

