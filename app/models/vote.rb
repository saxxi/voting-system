class Vote < ApplicationRecord
  belongs_to :candidate
  belongs_to :campaign

  def self.import_from_string(string)
    result = VoteParser.new(string).parse

    unless result.is_a?(Vote) && result.save
      reason = result.is_a?(Symbol) ? result : nil
      InvalidVote.new({
        raw: string,
        reason: reason,
      }).save
    end
  end
end
