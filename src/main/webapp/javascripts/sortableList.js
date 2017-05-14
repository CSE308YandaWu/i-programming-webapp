/**
 * Created by Shanshan.
 * Primarily for creating sortable list in editcourse.jsp
 */

var sel = $( "#sortable" );

$(function() {
    sel.sortable({
        //placeholder: "ui-state-highlight"
    });
    sel.disableSelection();
});