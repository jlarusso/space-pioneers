# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

console.log "hello?"
$(".game-container").fullpage({
  slideSpeed: 1000
  afterLoad: (a, i)->
    window.nextTurn()
    current = $('.section.active .question').data('id')
    console.log current
    setTimeout (->
      getChoice( current )
    ), 20000

  # afterRender: function(){},
  # afterResize: function(){},
  # afterSlideLoad: function(anchorLink, index, slideAnchor, slideIndex){},
  # onSlideLeave: function(anchorLink, index, slideIndex, direction){}
})
$(".header-intro h1").fitText(1)
$(".header-intro p").fitText(2)
$(".question").fitText(4.2)
$(".choice").fitText(2.0)
$(".planet-table").fitText(3.0)
$(".a-a-planet").each (i) ->
  $(@).jBox 'Modal',
      getTitle: "data-title",
      target: $(".planet-choices")
      position: {
        x: "center",
        y: "center"
      }
      outside: "x"
      animation: "slide"
      content: $(@).find(".tooltip-content")

$(".planet-choices .action-buttons").find(".btn").on "click", () ->
  $(".jBox-closeButton").trigger "click"


# Call this method passing in an event id, and it will the most recent
# tweet directed at @_spacepioneer that has a hashtag corresponding to the event.
# For example, say there are the following tweets created:
# @_spacepioneer #3 #a
# @_spacepioneer #4 #b
# @_spacepioneer #4 #a
# Calling getChoices(4) will return the third tweet because it is the most recent matching the question 4 hashtag
window.getChoice = (event_id) ->
  $.get "/choices/#{event_id}", (choice) ->

    other_letter = switch choice.letter
      when "b" then "a"
      when "a" then "b"

    wrong_choice = $('.section.active').find(".choice-#{other_letter}")
    wrong_choice.addClass('is-wrong-choice')
    wrong_choice.find('.choice-inner').fadeOut()
    wrong_choice.text("@#{choice.handle}")

    # Execute the function for the corresponding choice
    window.chooseEffect(choice.choice, wrong_choice)

    window.updateConditions()


window.updateConditions = ->
  $('#conditions-dashboard span').each ->
    $(this).text(window.conditions[this.id])


# $('body').keyup (e) ->
#   if e.keyCode == 32
#     window.getChoice $('.section.active .question').data('id')

