Campaign.create code: 'My campaign'
Campaign.create code: 'My other campaign'

%W{ssss_uk_01B Emmerdale}.each do |campaign_code|
  Campaign.new(code: campaign_code).save!
end

%W{
  Tupele Jane Mark
}.each do |candidate_code|
  Candidate.new(code: candidate_code).save!
end
