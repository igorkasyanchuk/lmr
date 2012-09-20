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
      # $("#street").val ''
      if $(this).val() != ''
        $("#street").attr "disabled", false

    $("#street").bind "input", ->
      if $(this).val() == ''
        $("#flat").val ''
        $("#house").val ''
        $("#flat").attr "disabled", true
        $("#house").attr "disabled", true
      init_street_autocomplete()

    $("#house").bind "input", ->
      if $(this).val() == ''
        $("#flat").val ''        
        $("#flat").attr "disabled", true
      init_house_autocomplete($('input[type=hidden]#user_street').val())

    $("#flat").bind "input", ->
      init_flat_autocomplete($('input[type=hidden]#user_house').val())


    init_street_autocomplete = ->
      $("#street").autocomplete
        source: "/users/autocomplete"
        minLength: 2
      $("#street").bind "autocompleteselect", (event, ui) ->
        $('input[type=hidden]#user_street').val ui.item.id
        $("#flat").val ''      
        $("#flat").attr "disabled", true
        $("#house").attr "disabled", false
        $("#house").val ''
        $('span.street_info').html ''
        init_house_autocomplete(ui.item.id)

    init_house_autocomplete = (street) ->
      $("#house").autocomplete source: "/users/autocomplete?street="+street
      $("#house").bind "autocompleteselect", (event, ui) ->
        $('input[type=hidden]#user_house').val ui.item.id
        $("#flat").attr "disabled", false
        $("#flat").val ''
        $('span.house_info').html ''
        init_flat_autocomplete(ui.item.id)

    init_flat_autocomplete = (house) ->
      $("#flat").autocomplete source: "/users/autocomplete?house="+house
      $("#flat").bind "autocompleteselect", (event, ui) ->      
       $('input[type=hidden]#user_flat').val ui.item.label


) jQuery