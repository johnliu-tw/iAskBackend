
require 'csv'
namespace :csv do 
task :load_data => [ :environment ] do
csv_text = File.expand_path('../rowdata.csv', __FILE__)
CSV.foreach(csv_text) do |row|
    Customer.create do |c|
        c.name = row[0]
        c.cnid = row[1]
    end
end
end
end