$(document).ready(function() {
  $('#nuacm_calendar').fullCalendar({
    events: "http://www.google.com/calendar/feeds/acm@ccs.neu.edu/public/basic",
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
