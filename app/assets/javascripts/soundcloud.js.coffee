console.log "what?"

$(document).on 'ready page:load', ->
  console.log "hello"

  $('#addTrack').on 'shown', ->
    console.log "shown method called"

    $(document).on 'click', '#select-record', ->
      console.log "clicked select record"
      $('#select-type').slideUp 'fast', ->
        $('#record-actions').slideDown 'fast'

    $(document).on 'click', '#record-actions #record', ->
      console.log "clicked record button"
      SC.record start: ->
        $('#record-actions #status').text('Recording')
        $('#record-actions #record').hide()
        $('#record-actions #stop').show()

    $(document).on 'click', '#record-actions #stop', ->
      console.log "clicked stop button"
      SC.recordStop()
      $('#record-actions #status').text('Stopped')
      $('#record-actions #stop').hide()
      $('#record-actions #record').show()
      $('#record-actions #pause').hide()
      $('#record-actions #play').css('color','#000000').show()

    $(document).on 'click', '#record-actions #play', ->
      console.log "clicked play button"
      SC.recordPlay()
      $('#record-actions #status').text('Playing')
      $('#record-actions #play').hide()
      $('#record-actions #pause').show()

    $(document).on 'click', 'div#upload', ->
      console.log "clicked upload"

