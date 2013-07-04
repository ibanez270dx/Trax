console.log "recorder.js.coffee"

$(document).on 'ready', ->
  console.log "ready"
  # Globals
  context = new webkitAudioContext()      # Web Audio API Context

  # Create a node to process audio
  scriptNode = context.createScriptProcessor(2048, 1, 1)

  # Connect to destination, else it isn't called
  scriptNode.connect(context.destination)

  scriptNode.onaudioprocess = (event) ->
    console.log "on audio process event"
    console.log event
    # get the average for the first channel
    array = new Uint8Array(analyser.frequencyBinCount)
    analyser.getByteFrequencyData(array)

    if micRunning
      array2 = new Uint8Array(analyser.frequencyBinCount)
      analyser.getByteTimeDomainData(array2)
      drawWave(array2)

  # Create a filter
  filter = context.createBiquadFilter()
  filter.type = 3
  filter.frequency.value = 440
  filter.Q.value = 0
  filter.gain.value = 0

  # Create an analyzer
  analyser = context.createAnalyser()
  analyser.smoothingTimeConstant = 0
  analyser.fftSize = 512

  # Create a buffer source node
  filter.connect(analyser)
  analyser.connect(scriptNode)

  # State variables
  micRunning = false

  # On Bootstrap's modal "shown" event
  # http://twitter.github.io/bootstrap/javascript.html#modals
  $('#createTrack').on 'shown', ->

    # Select Record
    $(document).on 'click', '#select-record', ->
      # Web Audio Setup
      navigator.webkitGetUserMedia {audio:true}, (stream) ->
        mediaStreamSource = context.createMediaStreamSource(stream)
        mediaStreamSource.connect(filter)
        micRunning = true


      # Animation
      $('#modal-label').fadeOut 'fast', ->
        $('#modal-label').text(' Record Track').removeClass().addClass('icon-microphone').fadeIn('fast')
      $('#select-type').animate
        top: '-250', 300, ->
          $('#record-actions').animate
            top: '-210', ->
              $('.modal-body').animate
                maxHeight: '300'

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
        $('#dashboard .track-list').html(data['html'])
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

