namespace :import do
  namespace :bikes do
    # Imports bikes info from CSV file
    task :csv, [:file] => :environment do |t, args|
      file = args[:file]
      next puts "Usage: rake #{t.name}[$csv_file_path]" unless file
      next puts "File #{file} does not exist or is unreachable" unless File.readable? file
      pp BikesCsvImporter.new(file).run
    end

    # Analyze a single field from CSV file
    task :analyze_csv, [:file, :field] => :environment do |t, args|
      file, field = args.values_at :file, :field
      next puts "Usage: rake #{t.name}[$csv_file_path[,\"$field_name\"]]" unless file
      next puts "File #{file} does not exist or is unreachable" unless File.readable? file
      pp BikesCsvImporter.new(file).analyze field ? [field] : []
    end
  end
end
