#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require jquery.turbolinks
#= require bigtext
#= require_tree .

$ ->

  # This is what allows the ACM logo to be dynamic size.
  # With turbolinks in use we need the jquery.turbolinks
  # gem to ensure this operates properly.
  $('.acm-logo').bigtext { 'resize' : false }
