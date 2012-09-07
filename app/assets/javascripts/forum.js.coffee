(($) ->
  $(document).ready ->   
    $("#new_user").autocomplete source: "/community/users/autocomplete"
    $("#new_user").bind "autocompleteselect", (event, ui) ->      
      $("#block_user").attr "disabled", false
      $("#new_user").attr 'user_id', ui.item.id

    block_user = ->
      user_id = $("#new_user").attr 'user_id'
      $.post "/community/toggle_approve",
        id: user_id

      $(this).attr "disabled", true
      $("#new_user").val ""

    $("#block_user").click block_user
    $("#new_user").keypress (e) ->
      block_user()  if e.which is 13


) jQuery