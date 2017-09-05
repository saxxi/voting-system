class CampaignsController < ApplicationController

  before_action :find_resource, only: [:show]

  def index
    @campaigns = Campaign.all
  end

  def show
    @candidate_votes = []
    @candidate_votes = Candidate.votes_for_campaign @campaign.id
  end

  private

  def find_resource
    @campaign = Campaign.find params[:id]
  end

end
