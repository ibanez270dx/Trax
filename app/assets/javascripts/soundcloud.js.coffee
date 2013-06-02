console.log "what?"

$(document).on 'ready page:load', ->
  # $('#track-details .upload, #track-details .upload-mask').hide()
  console.log "hello"

  # Initialize SoundCloud
  SC.initialize
    client_id: "085e90221f5237b6115e382cc2f4a1b2"
    redirect_uri: "http://localhost:3000/callback.html"

  # On Bootstrap's modal "shown" event
  # http://twitter.github.io/bootstrap/javascript.html#modals
  $('#createTrack').on 'shown', ->

    # Select Record
    $(document).on 'click', '#select-record', ->
      $('#modal-label').fadeOut 'fast', ->
        $('#modal-label').text(' Record Track').removeClass().addClass('icon-microphone').fadeIn('fast')
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

    # Alright, sounds good.
    $('#to-details').on 'click', (event) ->
      event.preventDefault()
      $('#modal-label').text(' Track Details').removeClass().addClass('icon-edit').fadeIn('fast')
      $('#record-actions').animate
        left: '-600', 600, 'easeInBack', ->
          $('#track-details').animate
            left: 0, 600, 'easeOutBack', ->
              console.log "animation complete"
          $('.modal-footer button').fadeOut 'fast', ->
            $('.modal-footer #modal-close, .modal-footer #to-upload').fadeIn('fast')

    # Save and Upload
    $('#to-upload').on 'click', (event) ->
      event.preventDefault()
      $('form#new_track').submit()

    $(document).on 'ajax:success', 'form#new_track', (event, data, status, xhr) ->
      form = $(this)
      console.log "HITTING: ", data
      if data['saved']
        $('#upload-to-soundcloud .ajax-loader').hide()
        $('#upload-to-soundcloud .status').text('Success!').delay(3000).queue ->
          $('#createTrack').modal('toggle')
      if data['valid']
        $('.modal-footer button').fadeOut('fast')
        console.log "valid"
        $('#upload-to-soundcloud-mask').fadeTo 'fast', '0.75', ->
          $('#upload-to-soundcloud').fadeIn 'fast', ->
            console.log "animation complete"
            SC.connect connected: ->
              console.log "connected..."
              SC.recordUpload
                track:
                  title: $('input#track_title').val()
                  description: $('textarea#track_description').html()
                  sharing: 'public'
              , (track) ->
                console.log "Now ajax save to the database..."
                console.log "Track: ", track
                form.find('#track_duration').val(track.duration)
                form.find('#track_soundcloud_id').val(track.id)
                form.find('#track_soundcloud_uri').val(track.uri)
                form.find('#track_soundcloud_permalink_url').val(track.permalink_url)
                form.submit()
      else
        $('div#track-details').html(data['html'])






    $(document).on 'click', '#upload', ->
      console.log "clicked upload"
      setState('upload')

