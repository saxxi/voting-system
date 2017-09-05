# Example
#   string = "VOTE 1168041837 Campaign:ssss_uk_01B Validity:during Choice:Leon CONN:MIG00VU MSISDN:00777770939999 GUID:88B52A7B-A182-405C-9AE6-36FCF2E47294 Shortcode:63334"
#   VoteParser.new(string).parse
class VoteParser

  def initialize(string = "")
    @string = clean(string).split(" ")
    @attributes = {}
  end

  def parse
    return :not_starting_with_vote unless starts_with_vote?
    return :error_parsing_voted_at unless voted_at = parsed_voted_at
    return :error_parsing_campaign_code unless campaign_id = parsed_campaign_id
    return :error_parsing_validity unless validity = parsed_validity
    return :error_parsing_candidate_code unless candidate_id = parsed_candidate_id

    Vote.new({
      is_valid: validity == 'during',
      campaign_id: campaign_id,
      candidate_id: candidate_id,
      voted_at: voted_at,
    })
  end

  def starts_with_vote?
    @string.length > 0 && @string[0] == 'VOTE'
  end

  def parsed_voted_at
    return nil unless @string[1].present? && @string[1] =~ /[0-9]{10}/
    DateTime.strptime(@string[1],'%s')
  end

  def parsed_campaign_id
    code = extract_value 2, 'Campaign'
    KeyValStore.get(:campaigns, code) ||
      Campaign.find_by(code: code).try(:first).try(:id)
  end

  def parsed_validity
    validity = extract_value 3, 'Validity'
    return nil unless validity.in? %W{during pre post}
    validity
  end

  def parsed_candidate_id
    code = extract_value 4, 'Choice'
    KeyValStore.get(:candidates, code) ||
      Candidate.find_by(code: code).try(:first).try(:id)
  end

  def extract_value(index, expected_key)
    key, value = @string[index].to_s.split(':')
    return nil unless key == expected_key
    return nil unless value.present?
    value
  end

  private

  def clean(string)
    string.encode('UTF-8', invalid: :replace).to_s
  end

end
