<% begin %>
  $('.counter_error').remove()
  $('.counters_loader').hide()
  $('#submit_counters').show()
<% end %>
<% @errors.each do |error| %>
  td_input = '#end_state_' + '<%= error.keys.first.gsub(' ', '_') %>'
  $("<div class='counter_error'>"+ '<%= error.values.first %>' + "</div>").insertAfter td_input
<% end %>