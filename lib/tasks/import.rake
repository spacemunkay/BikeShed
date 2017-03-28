namespace :import do
  namespace :bikes do
    # Imports bikes info from CSV file
    #
    #   rake import:bikes:csv[import.csv,dry] # dry run
    #   rake import:bikes:csv[import.csv]     # live import
    task :csv, [:file, :dry_run] => :environment do |t, args|
      file, dry_run = args.values_at :file, :dry_run
      next puts "Usage: rake #{t.name}[$csv_file_path[,$dry_run=dry]]" unless file
      next puts "File #{file} does not exist or is unreachable" unless File.readable? file
      BikeCsvImporter.new(file).run dry_run == 'dry'
    end

    # Analyze a single field from CSV file
    #
    #   rake import:bikes:analyze_csv[import.csv]           # dumps all fields data
    #   rake import:bikes:analyze_csv[import.csv,"date in"] # shows only single field
    task :analyze_csv, [:file, :field] => :environment do |t, args|
      file, field = args.values_at :file, :field
      next puts "Usage: rake #{t.name}[$csv_file_path[,\"$field_name\"]]" unless file
      next puts "File #{file} does not exist or is unreachable" unless File.readable? file
      BikeCsvImporter.new(file).analyze field ? [field] : []
    end

    # Imports new brands from CSV file
    #
    #   rake import:bikes:brands_csv[import.csv,dry] # dry run
    #   rake import:bikes:brands_csv[import.csv]     # live import
    task :brands_csv, [:file, :dry_run] => :environment do |t, args|
      file, dry_run = args.values_at :file, :dry_run
      next puts "Usage: rake #{t.name}[$csv_file_path[,$dry_run=dry]]" unless file
      next puts "File #{file} does not exist or is unreachable" unless File.readable? file
      BikeCsvImporter.new(file).brands dry_run == 'dry'
    end
  end
end
