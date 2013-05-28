jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

# Automatically dismiss flash messages after 5 seconds
setTimeout ->
  $('a[data-dismiss=alert]').click()
, 5000