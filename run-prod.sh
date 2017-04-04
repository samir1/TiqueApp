sudo RAILS_ENV=production rake db:migrate
sudo RAILS_ENV=production rake assets:precompile
sudo RAILS_ENV=production rails s -b 0.0.0.0 -p 80
