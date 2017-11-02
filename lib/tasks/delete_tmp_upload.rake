require 'rake'
namespace :file do 
task :delete_tmp_upload => [ :environment ] do
    FileUtils.rm_rf Dir.glob("#{Rails.root}/public/uploads/tmp/*") #public/tmp/screenshots etc
    #note the asterisk which deletes folders and files whilst retaining the parent folder
end
end