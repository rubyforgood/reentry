namespace :travis do
  desc "Things to run during Travis's before_script phase"
  task :before_script do
    raise unless system "psql -c 'create database reentry_test;' -U postgres"

    Rake::Task['db:schema:load'].invoke
  end
end
