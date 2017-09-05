class CampaignsController < ApplicationController

  before_action :find_resource, only: [:show]

  def index
    @campaigns = Campaign.all
  end

  def show
    @candidate_votes = []
  end

  private

  def find_resource
    @campaign = Campaign.find params[:id]
  end

end
