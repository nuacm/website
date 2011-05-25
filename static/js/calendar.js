$(document).ready(function() {
  $('#nuacm_calendar').fullCalendar({
    // US Holidays
    events: $.fullCalendar.gcalFeed(
     'http://www.google.com/calendar/feeds/acm@ccs.neu.edu/public/basic',
      {draggable: false, className: 'mygcal'}
      ),
      eventClick: function(event) {
	window.open(event.url, 'gcalevent', 'width=700,height=600');
	return false;
      },
      loading: function(bool) {
	if (bool) $('#loading').show();
	else $('#loading').hide();
      }
     });
 });
