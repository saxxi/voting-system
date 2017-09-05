namespace :import do

  desc 'import a voting file'
  task voting: :environment do
    File.open(get_filename, "r").each_line do |line|
      Vote.import_from_string line
    end
  end

  desc 'unique fields for column (dev only)'
  task :unique_fields, [:index] => :environment do |t, args|
    column_index = args[:index]
    raise "Please use the following format: eg. rake import:voting[3] docs/votes.txt" if column_index.blank?
    values = []
    File.open(get_filename, "r").each_line do |line|
      begin
        values << line.split(' ')[column_index.to_i]
      rescue
        puts line
      end
    end
    puts values.uniq
  end

  def get_filename
    raise "Please use the following format: eg. rake import:voting docs/votes.txt" if ARGV[1].blank?
    filename = File.join Rails.root, ARGV[1]
    raise "Voting file not found #{filename}" unless File.exist? filename
    filename
  end

end
