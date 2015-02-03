-- -----------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------
-- this script works like this:
--
-- * in the Finder select a number of images that can be placed on an illustrator file
-- * run the script
-- * if things worked well, the images should now be placed in the illustrator file
-- WARNING: most of the time the shoes are outside the artboard
-- I am too lazy to fix that
-- -----------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------

set x to 200
set W to 0
set H to 0
set dim_list to {}
set c to 1

tell application "Finder" to set item_cnt to selection

-- ------------------------------------------------------------------------
-- this part is the non-functional dialog to select the size of the grid
-- it does not do anything yet
-- ------------------------------------------------------------------------

set item_cnt to count of item_cnt 
set w to (item_cnt ^ 0.5) as integer as string
if w equal to item_cnt ^ 0.5 then
else
     set w to w + 1 as string
end if   
set h to 1 + (item_cnt / w) as integer
set board_size to display dialog "Set grid size for board of " & item_cnt & " items" default answer (w & " x " & h) with title "Choose grid size"

-- ------------------------------------------------------------------------
-- this is the working part
-- there is no reason for getting the finder selection twice
-- I think the script seemed not to work without it
-- and I am too scared to change it back
-- ------------------------------------------------------------------------

tell application "Finder"
    set selected_items to selection
    -- ------------------------------------------------------------------------
    -- this bit gets the image sizes so that they can be positioned neatly
    -- ------------------------------------------------------------------------
    tell application "Image Events"
         repeat with i in selected_items
	 	set u to open (i as alias)
		log i as string
	 	copy dimensions of u to {W, H}
		copy w to the end of dim_list
	 end repeat
    end tell
    -- ------------------------------------------------------------------------
    -- this is the actual positioning in illustrator
    -- ------------------------------------------------------------------------
    set file_items to selection
    tell application "Adobe Illustrator"
         repeat with i in selected_items
	     --  initial position
	     set item_position to {x, 300}
	     set placed_ref to make new placed item in document 1 with properties {file path: POSIX path of (i as alias), position: item_position}
	     scale placed_ref horizontal scale 50.0 vertical scale 50.0 
    	     set x to x + width of placed_ref + 20
    	 end repeat
    end tell
end tell
