iAskBackend command 

# Installtion and Deployment

## 1. Update necessary software
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties

## 2. Install Ruby with rvm

sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev

curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
echo 'gem: --no-ri --no-rdoc'  >> ~/.gemrc
echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc

rvm install 2.4.1
rvm use 2.4.1 --default

## 3.Install Passenger and Ngnix
gem install passenger

rvmsudo passenger-install-nginx-module
--> choose Ruby, 1.Yes : Download, compile and install nginx for me

## 4.Active nginx server
cd /etc/init.d
sudo wget https://raw.github.com/chloerei/nginx-init-ubuntu-passenger/master/nginx

sudo update-rc.d nginx defaults
sudo chmod +x nginx
sudo service nginx start
vim /opt/nginx/conf/nginx.conf
--> 
server {
  listen 80;
  server_name localhost;
  root /home/deploy/iAskBackend/public;   # add this line
  passenger_enabled on;               # add this line
}
## 5.Install DB ( Postgre SQL )
sudo apt-get install postgresql postgresql-contrib
sudo -u postgres psql

## 6.Bundle Install
sudo apt-get install libpq-dev
vim /home/deploy/iAskbackend/Gemfile
--> uncomment [ #gem 'therubyracer', platf orms: :ruby ] 
bundle install

## 7.Initial DB
RAILS_ENV=production rake db:create
RAILS_ENV=production rake db:migrate
RAILS_ENV=production bundle exec rake assets:precompile 
rake secret --> add the key to /iAskbackend/config/secrets.yml

touch tmp/restart.txt
sudo service nginx restart


# Command under root directory 

## 1. restart nginx web server 
ng_restart 
## 2. show server error log 
show_error 

# Command under /home/deploy/iAskBackend 
## 1.DB schema updated 
rake db:migrate RAILS_ENV=production 

## 2.Update and calculate log data (eg.correct rate or finished rate) 
rake create:student_paper_log RAILS_ENV=production 

## 3.Update student data from Firebase 
rake create:update_student_data RAILS_ENV=production 

## 4.Update paper_set data 
rake create:update_buyer_data RAILS_ENV=production 

## 5.Backup DB 
pg_dump -W -U postgres -h localhost daily_pratice >20180312.sql