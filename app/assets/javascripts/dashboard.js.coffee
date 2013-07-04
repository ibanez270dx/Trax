# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

if $('html').hasClass('dashboard')
  $(document).on 'ready', ->

    # doPoll = ->
    #   console.log "polling tracks"
    #   $.ajax
    #     url: '/dashboard/update'
    #   success: (data, status, jqXHR) ->
    #     $('#dashboard .track-listing').html(data['tracks'])
    #   setTimeout doPoll, 5000
    #
    # doPoll()