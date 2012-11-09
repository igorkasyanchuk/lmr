# encoding: utf-8
namespace :xls do
  desc "import xls files"
  require 'spreadsheet'
  Spreadsheet.client_encoding = 'UTF-8'
  task :import => :environment do
    tables = ["service_providers", "responsible_persons"]
    tables.each { |t| ActiveRecord::Base.connection.execute("TRUNCATE #{t}") }
    files = Dir["#{Rails.root}/import/*.xls"]   
    files.each do |file|
      puts "Reading from file #{file}".green
      book = Spreadsheet.open file
      book.worksheets.each do |sheet|
        clear_xls_heder sheet
        i = 0
        sheet.each do |row|
          unless row[0].blank?
            unless @service_provider.nil?
              @service_provider.save!
              @service_provider = nil
            end
            @service_provider = ServiceProvider.new
            @service_provider.code = sheet.row(i).at(0)
            @service_provider.name = sheet.row(i).at(1)
            @service_provider.address = [sheet.row(i).at(2), sheet.row(i+1).at(2), sheet.row(i+2).at(2)].join(' ')
            @service_provider.district = File.basename(file, ".xls").gsub(/[_]/, "і")
            @service_provider.phone = sheet.row(i+1).at(2)
            @service_provider.email = sheet.row(i).at(6) unless sheet.row(i).at(6).blank?
          end
          unless @service_provider.blank? || row.blank?
            @responsible_person = ResponsiblePerson.new
            unless row[3].blank?
              full_name = row.at(3).split(" ")
              @responsible_person.first_name = full_name[1]
              @responsible_person.middle_name = full_name[2]
              @responsible_person.last_name = full_name[0]
            end
            @responsible_person.incumbency = row.at(4).try(:chop!)
            unless row.at(5).blank?
              @responsible_person.phone = row.at(5)
            else
              @responsible_person.phone = @service_provider.phone
            end
            @responsible_person.email = @service_provider.email unless @service_provider.email.blank?
            @service_provider.responsible_persons << @responsible_person unless @responsible_person.blank?
          end
        i = i + 1
        end
      end
    end
  end

  def clear_xls_heder sheet
    3.times do |i|
      sheet.row(i).clear
    end
  end

end