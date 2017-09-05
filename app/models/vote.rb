class Vote < ApplicationRecord
  belongs_to :candidate
  belongs_to :campaign

  def self.import_from_string(string)
    result = VoteParser.new(string).parse
    if result.is_a?(Vote) && result.save
      'valid'
    else
      'invalid'
    end
  end
end
