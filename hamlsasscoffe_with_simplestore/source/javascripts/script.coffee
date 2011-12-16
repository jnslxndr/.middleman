#= require "jquery"
#= require "plugins/form2js"
#= require "plugins/jquery.toObject"

$ ->
  console.log "The Middleman is running Coffeescript with JQuery"
  
  $('button.getdata').click (event) ->
    $.get "data.json", (data) ->
      console.log "Antwort des Servers: ", data
    , "json"
    return false
  
  $('form').bind "submit", (event) ->
    console.log event.data,$(@).toObject(skipEmpty: false)
    $.post "data.json", $(@).toObject(skipEmpty: false), (data) ->
      console.log "Antwort des Servers: ", data
    return false