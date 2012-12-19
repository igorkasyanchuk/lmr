<% if @results.include?('false') %>  
  $('.counter_error').remove()
  $('.counters_loader').hide()
  $('#submit_counters').show()
  alert 'Помилка при внесенні показників!'
<% else %>  
  html_code = '<%= j render 'set_counter', :counters => @counters %>'
  $('#counters').html html_code
  alert 'Показники внесено успішно!'
<% end %>