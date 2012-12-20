year = '<%= params[:year] %>'
html_code = '<%= j render 'get_counter', :counter => @counter %>'
code = '<%= @counter.try(:code) %>'
$('#counter-' + code).html html_code
$('.counters_loader').hide()
print = $('#print_counter_' + code)
print_href = print.attr('href')
print_year = '&year=' + year
if print_href.indexOf('&year=') != -1
  clean_href = print_href.substring(0, print_href.indexOf('&year='))
  print.attr('href', clean_href)
  print.attr('href', (clean_href + print_year))
else
  print.attr('href', (print_href + print_year))
$('#' + code).val(year)