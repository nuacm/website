var members = {};

members.display_member = function(member) {
    var new_member = "<p><a href=\"http://ccs.neu.edu/home/" + member.username + "\">" + member.name + "</a></p>";
    $("#members").append(new_member);
};

$(function() {
    $.getJSON("/media/members.json", function(data) {
        for(var i = 0; i < data.length; i++) {
            members.display_member(data[i]);
        }
    });
});
