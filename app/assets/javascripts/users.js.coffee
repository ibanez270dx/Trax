# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:load', ->
  $('#soundcloud-connect .btn').on 'click', ->
    console.log "click"
    SC.connect ->
      SC.get "/me", (me) ->
        $('#user_soundcloud_id').val(me.id)
        $('#soundcloud-connect').append('<p class="text-success icon-ok"> Connected</p>')
        $('#soundcloud-connect .btn').hide()