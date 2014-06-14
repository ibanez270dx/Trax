# Place all globally available functions and initalizers here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready', ->

  # Bootstrap JS initialization
  jQuery ->
    $("a[rel=popover]").popover()
    $(".tooltip").tooltip()
    $("a[rel=tooltip]").tooltip()

  # Automatically dismiss flash messages after 5 seconds
  setTimeout ->
    $('a[data-dismiss=alert]').click()
  , 5000
