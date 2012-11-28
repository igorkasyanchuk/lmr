jQuery ->
  $('.radio_end_state').on 'change', (e) ->
    if $('.input_end_state').attr('disabled') == 'disabled'
      $('.input_end_state').prop('disabled', '')
      $('.input_amount_state').prop('disabled', 'disabled') 

  $('.radio_amount_state').on 'change', (e) ->
    if $('.input_amount_state').attr('disabled') == 'disabled'
      $('.input_amount_state').prop('disabled', '')
      $('.input_end_state').prop('disabled', 'disabled')  


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