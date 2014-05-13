$.fn.toggleSwitch = ->
  toggle = $(this)

  toggle.find('.btn').on 'click', (event) ->
    a = $(this).prev('li')
    b = $(this).next('li')

    if a.hasClass('toggle-active')
      offset = '-40px'
      a.removeClass('toggle-active')
      b.addClass('toggle-active')
    else
      offset = '0px'
      b.removeClass('toggle-active')
      a.addClass('toggle-active')

    $(this).closest('ul').animate
      left: offset
    , 500, 'easeInOutCubic'