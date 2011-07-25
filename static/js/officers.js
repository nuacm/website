var officers = {};

officers.display_officer = function(officer) {
    var office = officer.office;
    var display = officer.name
    if("term" in officer) {
        display = officer.term + ": " + display
    }
    $(".officer." + office).prepend("<span class=\"officer-name\">" + display + "</span>");
};

$(function() {
    $.getJSON("/media/officers.json", function(data) {
        for(var i = 0; i < data.length; i++) {
            officers.display_officer(data[i]);
        }
    });
});
