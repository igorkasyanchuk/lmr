jQuery ->
  $('.radio_end_state').on 'change', (e) ->
    if $('.input_end_state').attr('disabled') == 'disabled'
      $('.input_end_state').prop('disabled', '')
      $('.input_amount_state').prop('disabled', 'disabled') 

  $('.radio_amount_state').on 'change', (e) ->
    if $('.input_amount_state').attr('disabled') == 'disabled'
      $('.input_amount_state').prop('disabled', '')
      $('.input_end_state').prop('disabled', 'disabled')  


      