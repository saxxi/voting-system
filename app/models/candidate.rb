class Candidate < ApplicationRecord

  def self.votes_for_campaign(id)
    select("
        votes.candidate_id,
        candidates.code,
        SUM(CASE WHEN votes.is_valid THEN 1 ELSE 0 END) AS valid_votes,
        SUM(CASE WHEN votes.is_valid THEN 0 ELSE 1 END) AS invalid_votes
      ")
      .joins("LEFT JOIN votes ON votes.candidate_id = candidates.id")
      .where("votes.campaign_id = ?", id)
      .group("votes.candidate_id, candidates.code")
  end

end
