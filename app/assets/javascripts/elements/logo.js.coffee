# This is what allows the ACM logo to be dynamic size.

# On a "real" load event "reload page".
$(window).bind "load", ->
  $('.logo').bigtext { 'resize' : false }

# On a turboloaded event.
$(window).bind "page:load", ->
  $('.logo').bigtext { 'resize' : false }
