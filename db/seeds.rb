
%W{
  ssss_uk_01B Emmerdale ssss_uk_02A ssss_uk_zzactions ssss_uk_02B
}.each do |campaign_code|
  campaign = Campaign.new(code: campaign_code)
  campaign.save!
  KeyValStore.save :campaigns, campaign_code, campaign.id
end

%W{
  Antony Leon Tupele Jane Mark Verity Matthew Gemma GRAYSON Hayley Alan Elaine
  LEN ROSEMARY JIMMY JAMIE CARL MATTHEW TERRY BOB
}.each do |candidate_code|
  candidate = Candidate.new(code: candidate_code)
  candidate.save!
  KeyValStore.save :candidates, candidate_code, candidate.id
end

# Brutally simple tests (due time constraints)
# These tests are very easy to convert into proper unit tests
[
  [nil, "VOTE 1168041837 Campaign:ssss_uk_01B Validity:during Choice:Leon CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"],

  # Begin
  [:not_starting_with_vote, "VOT_E 1168041837 Campaign:ssss_uk_01B Validity:during Choice:Leon CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"],
  [:not_starting_with_vote, "1168041837 Campaign:ssss_uk_01B Validity:during Choice:Leon CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"],

  # VotedAt
  [:error_parsing_voted_at, "VOTE 116804183_7 Campaign:ssss_uk_01B Validity:during Choice:Leon CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"],
  [:error_parsing_voted_at, "VOTE Campaign:ssss_uk_01B Validity:during Choice:Leon CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"],

  # Campaign
  [:error_parsing_campaign_code, "VOTE 1168041837 Campaign:inexisting_campaign Validity:during Choice:Leon CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"],
  [:error_parsing_campaign_code, "VOTE 1168041837 Campaign: Validity:during Choice:Leon CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"],
  [:error_parsing_campaign_code, "VOTE 1168041837 ssss_uk_01B Validity:during Choice:Leon CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"],
  [:error_parsing_campaign_code, "VOTE 1168041837 Validity:during Choice:Leon CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"],

  # Validity
  [:error_parsing_validity, "VOTE 1168041837 Campaign:ssss_uk_01B Validity:invalid_here Choice:Leon CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"],
  [:error_parsing_validity, "VOTE 1168041837 Campaign:ssss_uk_01B Validity: Choice:Leon CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"],
  [:error_parsing_validity, "VOTE 1168041837 Campaign:ssss_uk_01B during Choice:Leon CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"],
  [:error_parsing_validity, "VOTE 1168041837 Campaign:ssss_uk_01B Choice:Leon CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"],

  # Choice
  [:error_parsing_candidate_code, "VOTE 1168041837 Campaign:ssss_uk_01B Validity:during Choice:inexisting_candidate CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"],
  [:error_parsing_candidate_code, "VOTE 1168041837 Campaign:ssss_uk_01B Validity:during Choice: CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"],
  [:error_parsing_candidate_code, "VOTE 1168041837 Campaign:ssss_uk_01B Validity:during CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"],
  [:error_parsing_candidate_code, "VOTE 1168041837 Campaign:ssss_uk_01B Validity:during Leon CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"],

  # Valid
  [nil, "VOTE 1168042332 Campaign:ssss_uk_01B Validity:during Choice:Gemma CONN:MIG01XU MSISDN:00777774649999 GUID:F9F2611D-1C3A-4512-9521-B4763B263326 Shortcode:63334"],
  [nil, "VOTE 1168042991 Campaign:ssss_uk_01B Validity:during Choice:Jane CONN:MIG01XU MSISDN:00777779929999 GUID:4D3A7108-1085-4EBB-936C-4B1F933FF1F0 Shortcode:63334"],
  [nil, "VOTE 1168044566 Campaign:ssss_uk_01B Validity:during Choice:Jane CONN:MIG01OU MSISDN:00777779289999 GUID:5E3C0350-4959-4FA9-919C-71ED199AF32A Shortcode:63334"],
  [nil, "VOTE 1168048062 Campaign:ssss_uk_01B Validity:during Choice:Antony CONN:MIG01XU MSISDN:00777778849999 GUID:7BF12723-C554-47A3-82A1-0ABFDEA200C2 Shortcode:63334"],
].each do |test|
  expected_result, string = test
  result = VoteParser.new(string).parse
  unless result == expected_result || (result.is_a?(Vote) && expected_result.blank?)
    raise "Unexpected result #{result} for #{string}"
  end
  result.save! if result.blank?
end
