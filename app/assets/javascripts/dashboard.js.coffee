jQuery ->

  amount_calc()
  submit_loader()

  $('#payment_terminal_type').on 'change', (e) ->
    if $(@).val() == 'Terminal'
      $('#payment_terminal_phone, #payment_terminal_bank, #payment_terminal_email').prop('disabled', 'disabled')
      $('.bank_department').hide()
    else if  $(@).val() == 'LkpDepartment'
      $('#payment_terminal_email, #payment_terminal_bank').prop('disabled', 'disabled')
      $('#payment_terminal_phone, #payment_terminal_email').prop('disabled', '')
      $('.bank_department').hide()
    else if $(@).val() == 'BankDepartment'  
      $('#payment_terminal_phone, #payment_terminal_email, #payment_terminal_bank').prop('disabled', '')
      $('.bank_department').show()
      $("#payment_terminal_department").autocomplete source: (request, response) ->
        $.ajax
          url: "/services/autocomplete"
          data: request
          success: (data) ->
            response data
    else
      $('.bank_department').hide()

window.amount_calc = ->
  $('.input_end_state').keyup ->    
    input_end_state = $(this).val()
    end_state = $(this).parent().prev().html()
    input_amount_state = $(this).parent().next().children()
    quantity = if isNaN(input_end_state) then '' else (input_end_state - end_state)
    input_amount_state.val quantity

window.submit_loader = ->
  $('#submit_counters').on 'click', ->
    $(this).hide()
    $(this).next().show()
    $('form#form_counters').submit()
    false


  # $('.show_map').on 'click', ->
  #   window.location.hash = ''
  #   id = $(this).attr('id')

  #   jQuery.each Gmaps.map.markers, ->
  #     _id = this.id.toString()
  #     if id == _id
  #       infowindow = this.infowindow
  #       infowindow.open(Gmaps.map.map, this.serviceObject)
  #       Gmaps.map.map.setZoom(18)
  #       window.location.hash = 'payment_map'
  #     else
  #       this.infowindow.close()