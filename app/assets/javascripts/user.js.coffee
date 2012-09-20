(($) ->
  $(document).ready ->

    if $("#user_identifier").val() != ''
      $("#street").attr "disabled", false
    
    if $('input[type=hidden]#user_street').val() != ''
      $("#street").attr "disabled", false

    if $('input[type=hidden]#user_house').val() !=''
      $("#house").attr "disabled", false

    if $('input[type=hidden]#user_flat').val() !=''
      $("#flat").attr "disabled", false

    $("#street").focusin(->
      $('span.address_error').html ''
      $('span.street_info').html 'Виберіть вулицю зі списку'
    ).focusout ->
      if $('input[type=hidden]#user_street').val() == ''
        $('span.street_info').html 'Виберіть вулицю зі списку'

    $("#house").focusin(->
      $('span.address_error').html ''
      $('span.house_info').html 'Виберіть дім зі списку'
    ).focusout ->
      if $('input[type=hidden]#user_house').val() == ''
        $('span.house_info').html 'Виберіть дім зі списку'

    $("#flat").focusin(->
      $('span.address_error').html ''
      $('span.flat_info').html 'Виберіть квартиру зі списку'
    ).focusout ->
      if $('input[type=hidden]#user_flat').val() == ''
        $('span.flat_info').html 'Виберіть квартиру зі списку'


    $("#user_identifier").bind "input", ->
      if $(this).val() != ''
        $("#street").attr "disabled", false

    $("#street").bind "input", ->
      if $(this).val() == ''
        $('input[type=hidden]#user_flat, input[type=hidden]#user_house, input[type=hidden]#user_street').val ''
        $("#house, #flat").val ''
        $("#house, #flat").attr "disabled", true
      init_street_autocomplete()

    $("#house").bind "input", ->
      if $(this).val() == ''
        $('#flat, input[type=hidden]#user_flat, input[type=hidden]#user_house').val ''        
        $("#flat").attr "disabled", true
      init_house_autocomplete($('input[type=hidden]#user_street').val())

    $("#flat").bind "input", ->
      init_flat_autocomplete($('input[type=hidden]#user_house').val())


    init_street_autocomplete = ->
      $("#street").autocomplete source: (request, response) ->
        $.ajax
          url: "/users/autocomplete"
          data: request
          success: (data) ->
            response data
            response [{ value: 0, label: "Нічого не знайдено!"}] if data.length is 0
          error: ->
            response []

      $("#street").bind "autocompleteselect", (event, ui) ->
        if ui.item.value is 0          
          $('#street, input[type=hidden]#user_street').val ''
          return false
        $('input[type=hidden]#user_street').val ui.item.id
        $("#house, #flat").val ''
        $("#flat").attr "disabled", true
        $("#house").attr "disabled", false        
        $('span.street_info').html ''
        init_house_autocomplete(ui.item.id)


    init_house_autocomplete = (street) ->
      $("#house").autocomplete source: (request, response) ->
        $.ajax
          url: "/users/autocomplete?street="+street
          data: request
          success: (data) ->
            response data
            response [{ value: 0, label: "Нічого не знайдено!"}] if data.length is 0
          error: ->
            response []
      $("#house").bind "autocompleteselect", (event, ui) ->
        if ui.item.value is 0          
          $('#house, input[type=hidden]#user_house').val ''
          return false
        $('input[type=hidden]#user_house').val ui.item.id
        $("#flat").attr "disabled", false
        $("#flat").val ''
        $('span.house_info').html ''
        init_flat_autocomplete(ui.item.id)

    init_flat_autocomplete = (house) ->
      $("#flat").autocomplete source: (request, response) ->
        $.ajax
          url: "/users/autocomplete?house="+house
          data: request
          success: (data) ->
            response data
            response [{ value: 0, label: "Нічого не знайдено!"}] if data.length is 0
          error: ->
            response []
      $("#flat").bind "autocompleteselect", (event, ui) ->
        if ui.item.value is 0
          $('#flat, input[type=hidden]#user_flat').val ''
          return false
        $('input[type=hidden]#user_flat').val ui.item.label
        $('span.flat_info').html ''


) jQuery