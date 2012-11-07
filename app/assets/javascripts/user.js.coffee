(($) ->
  $(document).ready ->

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

      $("#street").on "autocompleteselect", (event, ui) ->
        if ui.item.value is 0          
          $('#street, input[type=hidden]#user_street').val ''
          return false
        $('input[type=hidden]#user_street').val ui.item.id
        $("#house, #user_flat").val ''
        $("#user_flat").attr "disabled", true
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
      $("#house").on "autocompleteselect", (event, ui) ->
        if ui.item.value is 0          
          $('#house, input[type=hidden]#user_house').val ''
          return false
        $('input[type=hidden]#user_house').val ui.item.id
        $("#user_flat").attr "disabled", false
        $("#user_flat").val ''
        $('span.house_info').html ''

    # bind input of fields street house flat

    $("#user_identifier").on "input", ->
      if $(this).val() != ''
        $("#street").attr "disabled", false

    $("#street").on "input", ->
      if $(this).val() == ''
        $('input[type=hidden]#user_flat, input[type=hidden]#user_house, input[type=hidden]#user_street').val ''
        $("#house, #user_flat").val ''
        $("#house, #user_flat").attr "disabled", true
      init_street_autocomplete()

    $("#house").on "input", ->
      if $(this).val() == ''
        $('#user_flat, input[type=hidden]#user_house').val ''        
        $("#user_flat").attr "disabled", true
      init_house_autocomplete($('input[type=hidden]#user_street').val())

    # end of binding

    # disable fields when no in input
    init_street_autocomplete() #enable street autocomplete when no identifier

    if $("#user_identifier").val() != ''
      $("#street").attr "disabled", false
    
    if $('input[type=hidden]#user_street').val() != ''
      $("#street, #house").attr "disabled", false
      init_house_autocomplete($('input[type=hidden]#user_street').val())

    if $('input[type=hidden]#user_house').val() != ''
      $("#house, #user_flat").attr "disabled", false

    if $('#user_flat').val() != ''
      $("#user_flat").attr "disabled", false
    # end disable fields when no in input

    
    #  actions when focusin focusout
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

    $("#user_flat").focusin(->
      $('span.address_error').html ''
      $('span.flat_info').html 'Введіть номер квартири'
    ).focusout ->
      if $('#user_flat').val() == ''
        $('span.flat_info').html 'Введіть номер квартири'
      else
        $('span.flat_info').html ''

    #  end of actions when focusin focusout

    # confirmation
    $("input:checkbox#accepted").on "change", ->
      if $(this).is(":checked")
        $('a.confirm').removeAttr('disabled')
      else
        $('a.confirm').attr('disabled', 'disabled')

    $.rails.allowAction = (link) ->
      return true unless link.attr('data-confirm')
      $.rails.showConfirmDialog(link) # look bellow for implementations
      false # always stops the action since code runs asynchronously

    $.rails.confirmed = (link) ->
      link.removeAttr('data-confirm')      
      link.trigger('click.rails')

    $.rails.showConfirmDialog = (link) ->
      message = link.attr 'data-confirm'
      $('a.confirm').attr('disabled', 'disabled')
      $("input:checkbox#accepted").removeAttr('checked')
      $("#confirmationDialog").modal()
      $('#confirmationDialog .confirm').on 'click', -> 
        if $('input:checkbox#accepted').is(":checked")
          $.rails.confirmed(link)
        else
          false
    # end of confirmation


) jQuery