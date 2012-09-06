namespace :dbf do
	desc "import dbf files"
	task :import => :environment do
		# clean tables
		require 'dbf'
		tables = ["streets", "houses", "consumers"]
		tables.each { |t| ActiveRecord::Base.connection.execute("TRUNCATE #{t}") }
		# end clean
		streets = DBF::Table.new('public/STREET.DBF')
		puts "Streets import started"
		streets.each do |record|
			Street.create(:id => record["KODSTRT"], :name => record["DESCRIPT"], :deleted => record["DELETION"])
		end

		puts "Streets import finished"

		houses = DBF::Table.new('public/HOUSE.DBF')
		puts "Houses import started"
		houses.each do |record|
			House.create(:id => record["KODHOUSE"], :description => record["DESCRIPT"], :deleted => record["DELETION"], :firm_id => record["KODFIRM"], :street_id => record["KODSTRT"], :number_code => record["NUMBER"], :letter => record["LETTER"] )
		end

		puts "Houses import finished"

		consumers = DBF::Table.new('public/CONSUMER.DBF')
		puts "Consumers import started"
		consumers.each do |record|
			Consumer.create(:code => record["KODCONS"], :description => record["DESCRIPT"], :deleted => record["DELETION"], :house_id => record["KODHOUSE"], :flat => record["FLAT"], :entrance => record["ENTRANCE"], :floor => record["FLOOR"], :calc_area => record["CALCAREA"], :heat_area => record["HEATAREA"], :numbrsdn => record["NUMBRSDN"], :numbmgst => record["NUMBMGST"], :letter => record["LETTER"] )
		end
		puts "Consumers import finished"

	end


end