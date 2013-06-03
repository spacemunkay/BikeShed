#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

Rake::TaskManager.class_eval do
  def remove_task(task_name)
    @tasks.delete(task_name.to_s)
  end
end

require File.expand_path('../config/application', __FILE__)

Velocipede::Application.load_tasks

unless Rails.env.production?

  namespace :spec do
    desc 'Run all acceptance specs'
    RSpec::Core::RakeTask.new(:acceptance => 'db:test:prepare') do |t|
      t.pattern = '**/*.feature'
    end
  end

  Rake.application.remove_task 'spec'

  desc 'Run all specs'
  RSpec::Core::RakeTask.new(:spec => 'db:test:prepare') do |t|
    t.pattern = '**/*{_spec.rb,.feature}'
  end

end
