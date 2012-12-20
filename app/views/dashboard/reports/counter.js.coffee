year = '<%= params[:year] %>'
html_code = '<%= j render 'get_counter', :counter => @counter %>'
code = '<%= @counter.code %>'
$('#counter-' + code).html html_code
$('.counters_loader').hide()
$('#' + code).val(year)