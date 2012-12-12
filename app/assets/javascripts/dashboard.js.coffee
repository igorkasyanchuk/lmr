jQuery ->

  $('.input_end_state').keyup ->    
    input_end_state = $(this).val()
    end_state = $(this).parent().prev().html()
    input_amount_state = $(this).parent().next().children()
    quantity = if isNaN(input_end_state) then '' else (input_end_state - end_state)
    input_amount_state.val quantity

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