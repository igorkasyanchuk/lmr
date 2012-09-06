(($) ->
  $(document).ready ->

    if $("#user_identifier").val() != ''
      $("#street").attr "disabled", false

    $("#user_identifier").bind "input", ->
      # $("#street").val ''
      if $(this).val() != ''
        $("#street").attr "disabled", false


    $("#street").autocomplete source: "/users/autocomplete"
    $("#street").bind "autocompleteselect", (event, ui) ->
      $('input[type=hidden]#user_street').val ui.item.id
      $("#flat").val ''      
      $("#flat").attr "disabled", true
      $("#house").attr "disabled", false
      $("#house").val ''
      init_house_autocomplete(ui.item.id)



    init_house_autocomplete = (street) ->
      $("#house").autocomplete source: "/users/autocomplete?street="+street
      $("#house").bind "autocompleteselect", (event, ui) ->
        $('input[type=hidden]#user_house').val ui.item.id
        $("#flat").attr "disabled", false
        $("#flat").val ''
        init_flat_autocomplete(ui.item.id)

    init_flat_autocomplete = (house) ->
      $("#flat").autocomplete source: "/users/autocomplete?house="+house
      $("#flat").bind "autocompleteselect", (event, ui) ->      
       $('input[type=hidden]#user_flat').val ui.item.label


) jQuery