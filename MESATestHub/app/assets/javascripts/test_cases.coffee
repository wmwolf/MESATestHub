# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

index = 
  setup: ->
    index.make_rows_clickable()
  make_rows_clickable: ->
    $(".clickable-row").css('cursor', 'pointer')
    $(".clickable-row").click( -> window.location = $(this).data("href"))

$ -> 
  index.setup()

