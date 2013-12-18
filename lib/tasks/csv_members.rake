require "csv"

desc "Import a batch of simple members from a csv of names and emails"
task :import_members, [:path] => :environment do |t,args|
  CSV.foreach(File.expand_path(args[:path])) do |row|
    if row.size == 2
      begin
        Member.create!(:name => row[0], :email => row[1].strip)
        puts "SUCCESS: #{row.join(' ')}"
      rescue ActiveRecord::RecordInvalid => e
        puts "ERROR: Problem creating member, :name => #{row[0]}, :email => #{row[1]}"
        puts "       #{e.message}"
      end
    else
      puts "ERROR: Invalid entry #{row.join(' ')}"
    end
  end
end

desc "Export members to csv file, in the following format (last, first, email)"
task :export_members, [:path] => :environment do |t,args|
  CSV.open("#{args[:path]}.csv", "wb") do |csv|
    Member.all.each do |m|
      csv << [m.name, m.email]
    end  
  end
end

