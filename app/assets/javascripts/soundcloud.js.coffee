console.log "what?"

$(document).on 'ready page:load', ->
  console.log "hello"

  # Initialize SoundCloud
  SC.initialize
    client_id: "085e90221f5237b6115e382cc2f4a1b2"
    redirect_uri: "http://localhost:3000/callback.html"

  # On Bootstrap's modal "shown" event
  # http://twitter.github.io/bootstrap/javascript.html#modals
  $('#addTrack').on 'shown', ->

    # Select Record
    $(document).on 'click', '#select-record', ->
      $('#select-type').animate
        top: '-250', 300, ->
          $('#record-actions').animate
            top: '-210'

    ########################################
    # Recording Interface
    ########################################
    status = $('#record-actions #status')
    record = $('#record-actions #record')
    play = $('#record-actions #play')
    stop = $('#record-actions #stop')

    setState = (state) ->
      switch state
        when "stop"
          status.text('Stopped');play.show();stop.hide();record.show();
          play.removeClass('disabled')
          record.removeClass('disabled')
        when "play"
          status.text('Initializing...');play.hide();stop.show();record.show();
          record.addClass('disabled') unless record.hasClass('disabled')
        when "record"
          status.text('Initializing...');play.show();stop.show();record.hide();
        when "upload"
          status.text('Uploading...')

    $(document).on 'click', '#record-actions #record', ->
      unless $(this).hasClass('disabled')
        play.addClass('disabled') unless play.hasClass('disabled')
        SC.record
          start: ->
            setState('record')
          progress: (ms) ->
            status.text("Recording... #{SC.Helper.millisecondsToHMS(ms)}")

    $(document).on 'click', '#record-actions #stop', ->
      SC.recordStop()
      setState('stop')
      $('#to-details').fadeIn('fast') unless $('#to-details').is(':visible')

    $(document).on 'click', '#record-actions #play', ->
      unless $(this).hasClass('disabled')
        setState('play')
        SC.recordPlay
          progress: (ms) ->
            status.text("Playing... #{SC.Helper.millisecondsToHMS(ms)}")
          finished: ->
            setState('stop')

    $('#to-details').on 'click', (event) ->
      event.preventDefault()
      $('#record-actions').animate
        left: '-600', 600, 'easeInBack', ->
          $('#track-details').animate
            left: 0, 600, 'easeOutBack', ->
              console.log "animation complete"
          $('.modal-footer button').fadeOut 'fast', ->
            $('.modal-footer #modal-close, .modal-footer #to-upload').fadeIn('fast')









    $(document).on 'click', '#upload', ->
      console.log "clicked upload"
      setState('upload')
      SC.connect connected: ->
        console.log "connected..."
        SC.recordUpload
          track:
            title: 'testing uploadz'
            sharing: 'public'
        , (track) ->
          console.log "Track: ", track

