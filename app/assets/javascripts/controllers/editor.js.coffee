# Place all the behaviors and hooks related to the Editor controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

if $('html').hasClass('dashboard')

  $(document).ready ->
    $('div#drag-or-upload div.clickbox').click ->
      $('div#drag-or-upload input[type=file]').trigger('click')
