// Proof of concept showing how to extract a part list with colors from an Illustrator file

#target illustrator

//---------------------------------------------------------------------------------------
// this functions recurses through groups (GroupItems, CompoundPathItems)
// and executes a callback against each one
// it's necessary for example because group items don't _have_ a color, so you have 
// to dig into each sub-element to find out
//---------------------------------------------------------------------------------------
function recurseGroup(g, callBack) {
    callBack(g);
    switch(g.typename) {
    case 'GroupItem': {
	    // callBack(g);
	    var i = 0;
	    for (i = 0; i < g.pageItems.length; i++) { recurseGroup(g.pageItems[i], callBack) }
	}
	break;
    case 'CompoundPathItem': {
	    // callBack(g);
	    var j = 0;
	    for (j = 0; j < g.pathItems.length; j++) { recurseGroup(g.pathItems[j], callBack) }
	}
	break;
    default:
	break;
    }
    return;
}

//---------------------------------------------------------------------------------------
// this functions climbs up through the parents of an element until if finds one
// with a name, and returns it
// sub-elements in a group might not have a name, so this way you can take the
// one from the closest ancestor as a substitute
//---------------------------------------------------------------------------------------
function getParentName(g) {
    if (g.name) {
	return g.name
    } else {
	while (g.parent.name.length == 0) { g = g.parent }
	return g.parent.name;
    }
} 


//---------------------------------------------------------------------------------------
// recurse through the selection, get color names for the elements
// assign the color names to a list
// output the list
// it could be improved to check if a part is colored up in more than one color
//---------------------------------------------------------------------------------------
function createPartList() {
    var colorList = {};
    for (var i = 0; i < selection.length; i++) {
	var sel = app.activeDocument.selection[i];	
	recurseGroup(sel, function(d) {
	    // see if the element has a spot color
	    var s; try { s = d.fillColor.spot.name } catch (e) { };
	    // if it's got one...
	    if (s) {
		// get the closest ancestor's name and push the color onto the list
		var elName = getParentName(d);
		if (!(colorList[elName])) { colorList[elName] = [] };
		colorList[elName].push(s)
	    } 
	});
    }
    // return the list as JSON
    $.writeln(colorList.toSource());
}

createPartList()
