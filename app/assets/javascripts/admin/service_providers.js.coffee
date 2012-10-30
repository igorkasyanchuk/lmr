jQuery ->
  $(document).live "click", ->
    $('input[type = tel]').mask("(999) 999-99-99")