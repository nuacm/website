$(document).ready(function() {
  $('#nuacm_calendar').fullCalendar({
    eventSources: [
	    "http://www.google.com/calendar/feeds/acm@ccs.neu.edu/public/basic",
        {
            url: "https://www.google.com/calendar/feeds/4odaugkub8mh5dhkjpj3l0k69o%40group.calendar.google.com/public/basic",
            color: "purple"
        },
        {
            url: "https://www.google.com/calendar/feeds/i12mi27ov8nupmg6gl56i6vl74%40group.calendar.google.com/public/basic",
            color: "green"
        }
    ],
    eventClick: function(event) {
      window.open(event.url, 'gcalevent', 'width=700,height=600');
      return false;
    },
    loading: function(bool) {
      if (bool) $('#loading').show();
      else $('#loading').hide();
    },
    header: { left: "today prev,next", center: "title", right: "month,agendaWeek"}
  });
});
