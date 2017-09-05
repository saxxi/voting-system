namespace :import do

  desc 'import a voting file'
  task voting: :environment do
    raise "Please use the following format: eg. rake import:voting docs/votes.txt" if ARGV[1].blank?
    filename = File.join Rails.root, ARGV[1]
    raise "Voting file not found #{filename}" unless File.exist? filename

    File.open(filename, "r").each_line do |line|
      Vote.import_from_string line
    end
  end

end
