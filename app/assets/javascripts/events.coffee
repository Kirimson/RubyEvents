# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  file_input = $('#event_image')

  loadImage = ->
    file = file_input[0].files[0]

    image = $('.event-image')
    reader = new FileReader()
    reader.onload = (e) => image.attr('src', e.target.result)
    reader.readAsDataURL(file)

  file_input.change(loadImage)