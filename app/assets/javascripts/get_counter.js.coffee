jQuery ->
  # $( "#tabs" ).tabs()
  counters = $(".counter_year")
  jQuery.each counters, ->    
    $(this).on 'change', ->
      code = $(this).attr("id")
      year = $(this).val()
      $.ajax
        url: '/dashboard/counter'
        data:
          code: code
          year: year