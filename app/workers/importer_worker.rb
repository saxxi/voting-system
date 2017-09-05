# eg. ImporterWorker.import_from_file 'docs/votes.txt'
class ImporterWorker
  include Sidekiq::Worker

  def self.import_from_file(file)
    filename = File.join Rails.root, file
    File.open(filename, "r").each_line do |line|
      ImporterWorker.perform_async line
    end
  end

  def perform(string)
    Vote.import_from_string(string)
  end

end
