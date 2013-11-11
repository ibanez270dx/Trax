class QuickRecorder

  constructor: (editor, options) ->
    @editor = editor
    @waveform = @editor.find('canvas#input')[0].getContext("2d")
    @clipping = @editor.find('canvas#clipping')[0].getContext("2d")

    [@micRunning, @isRecording] = [false, false]
    @chromaOrange = new chroma.scale(["#00ff00", "#e0e000", "#ff7f00", "#b60101"]).domain([128, 255])
    @context = new webkitAudioContext()
    @scriptProcessor = @context.createScriptProcessor(2048, 1, 1)
    @scriptProcessor.connect(@context.destination)

    @analyser = @context.createAnalyser()
    @analyser.smoothingTimeConstant = 0
    @analyser.fftSize = 512
    @analyser.connect(@scriptProcessor)
    @_setupAudioHandler()
    @_setupClickHandlers()

    # Start Reading Mic Input
    navigator.webkitGetUserMedia { audio: true }, (stream) =>
      @micSource = @context.createMediaStreamSource(stream)
      @micSource.connect(@analyser)
      @micRunning = true

  _setupAudioHandler: =>
    @scriptProcessor.onaudioprocess = =>
      array = new Uint8Array(@analyser.frequencyBinCount)
      @analyser.getByteTimeDomainData(array)
      if @micRunning
        @_drawLiveWaveform(array)
        @_drawClipping(array)

  _drawLiveWaveform: (array) =>
    @waveform.clearRect(0, 0, 80, 60)
    for i in [0..array.length]
      value = array[i]
      @waveform.fillStyle = @chromaOrange(value / 255).hex()
      @waveform.fillRect((i * 100) / 255, (value / 2) - 49, 1, 1)

  _drawClipping: (array) =>
    @clipping.clearRect(0, 0, 80, 60)
    value = Math.max.apply(Math, array)
    @clipping.fillStyle = '#2f2f2f'
    @clipping.fillRect(0, 0, 80, 30-((value-128)*30/100))

  _setupClickHandlers: =>
    @editor.find('.mic-switch').on 'click', (event) =>
      a = $(event.currentTarget).prev('li')
      b = $(event.currentTarget).next('li')
      if a.hasClass('slider-active')
        # start up microphone
        navigator.webkitGetUserMedia { audio: true }, (stream) =>
          @micSource = @context.createMediaStreamSource(stream)
          @micSource.connect(@analyser)
          @micRunning = true

      if b.hasClass('slider-active')
        # stop mic
        @micSource.disconnect(@analyser)
        @micRunning = false
        @waveform.clearRect(0, 0, 80, 60)
        @clipping.fillRect(0, 0, 80, 60)

    @editor.find("#rec-start").on 'click', (event) =>
      if !$(this).closest("div.record").hasClass("disabled")
        $("div.record i").addClass("active")
        @_resetTrack()
        @isRecording = true
        @_drawGrid()

    @editor.find("#rec-stop").on 'click', (event) =>
      $("div.record i").removeClass("active")
      @isRecording = false



$(document).on 'ready', ->

  # Slider
  $('.btn-slider').each ->
    $(this).find('.btn').on 'click', (event) ->
      a = $(this).prev('li')
      b = $(this).next('li')

      if a.hasClass('slider-active')
        offset = '-40px'
        a.removeClass('slider-active')
        b.addClass('slider-active')
      else
        offset = '0px'
        b.removeClass('slider-active')
        a.addClass('slider-active')

      $(this).closest('ul').animate
        left: offset
      , 500, 'easeInOutCubic'

  if $('html').hasClass('dashboard')
    console.log "ready"

    ########################################
    # Initialization by Modal
    ########################################

    # On Bootstrap's modal "shown" event
    # http://twitter.github.io/bootstrap/javascript.html#modals
    $('#createTrack').on 'shown', ->

      # Select Record
      $(document).on 'click', '#select-record', ->

        # Web Audio Setup
        new QuickRecorder $('[data-quick-recorder]')

        # Animation
        $('#modal-label').fadeOut 'fast', ->
          $('#modal-label').text(' Record Track').removeClass().addClass('icon-microphone').fadeIn('fast')

        $('#select-type').animate
          top: '-250', 300, ->
            $('#record-actions').animate
              top: '-210', ->
                $('.modal-body').animate
                  maxHeight: '265'
                  paddingTop: '2'

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

      # $(document).on 'click', '#record-actions #record', ->
      #   unless $(this).hasClass('disabled')
      #     play.addClass('disabled') unless play.hasClass('disabled')
      #     SC.record
      #       start: ->
      #         setState('record')
      #       progress: (ms) ->
      #         status.text("Recording... #{SC.Helper.millisecondsToHMS(ms)}")

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

