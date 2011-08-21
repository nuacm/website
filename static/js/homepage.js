google.load("gdata", "2.x", {packages: ["calendar"]});

google.setOnLoadCallback(function () {
  var service = new google.gdata.calendar.CalendarService("acm-events");
  var query = new google.gdata.calendar.CalendarEventQuery("http://www.google.com/calendar/feeds/acm@ccs.neu.edu/public/full");
  query.setOrderBy('starttime');
  query.setSortOrder('ascending');
  query.setFutureEvents(true);
  query.setMaxResults(10);
  var event_tmpl = tmpl("event_tmpl");
  var event_list = $("#events-list");
  service.getEventsFeed(query, function(root) {
    var entries = root.feed.getEntries();
    for(var i = 0; i < entries.length; i++) {
      var entry = entries[i];
      var locations = entry.getLocations();
      var times = entry.getTimes();
      event_list.append(event_tmpl({title: entry.title.getText(),
                                    where: locations.length > 0 ? locations[0].getValueString() : "",
                                    when: times.length > 0 ? times[0].getStartTime().getDate().toString("M/d h:mmtt") : "",
                                    content: entry.content.getText() }));
    }
  })
});
