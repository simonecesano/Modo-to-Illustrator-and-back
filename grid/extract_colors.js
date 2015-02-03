// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// this script extractes a series of PNGs, one for each spotcolor or
// gradientcolor that is used inside the selection
// it works like this:
//     - select a pageitem
//     - run the script
//     - done!
// If things worked OK, you should have a number of PNGs named according
// to a template like this: filename-colorname.png
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#target illustrator

var options = new ExportOptionsPNG24();
options.antiAliasing = true;
options.transparency = true;
options.artBoardClipping = true;

function recurseGroup(g, callBack) {
    switch(g.typename) {
    case 'GroupItem': {
	    var i = 0;
	    for (i = 0; i < g.pageItems.length; i++) { recurseGroup(g.pageItems[i], callBack) }
	}
	break;
    case 'CompoundPathItem': {
	    var j = 0;
	    for (j = 0; j < g.pathItems.length; j++) { recurseGroup(g.pathItems[j], callBack) }
	}
	break;
    default:
	callBack(g);
	break;
    }
    return;
}

var list = {};

function getColor(s) {
    var spotName;
    try { spotName = s.fillColor.spot.name } catch (e) { try { spotName = s.fillColor.gradient.name } catch(e) { } }
    if (spotName) {
	if (typeof list[spotName] === 'undefined') { list[spotName] = [] }
	list[spotName].push(s)
    }
    s.hidden = true;
}


var root = app.activeDocument.fullName.fullName.replace(/\.[^\.]+/, "");
for (var i = 0; i < selection.length; i++) {
    recurseGroup(app.activeDocument.selection[i], function(d) { getColor(d) });
}

var visited_elements = [];

for (var prop in list) {
    for (j = 0; j < list[prop].length; j++) { list[prop][j].hidden = false }
    var file_name = (root + '-' + prop.replace(/\s+/g, '_') + '.png').toLowerCase();
    var file = new File(file_name);
    app.activeDocument.exportFile(file, ExportType.PNG24, options);
    for (j = 0; j < list[prop].length; j++) { list[prop][j].hidden = true; visited_elements.push(list[prop][j])  }
}

for (var i = 0; i < visited_elements.length; i++) {
    visited_elements[i].hidden = false;
}
