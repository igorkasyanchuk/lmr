# encoding utf-8
year = '<%= params[:year] %>'
html_code = '<%= j render 'get_counter', :history => @counter.history(@year) %>'
code = '<%= @counter.code %>'
$('#counter-' + code).html html_code
$('#' + code).val(year)
alert 'Показник внесено успішно!'