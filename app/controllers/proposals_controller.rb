class ProposalsController < ApplicationController

  def index
    @proposals = Proposal.all
  end

  def new
    @proposal = Proposal.new
    @registration = Registration.find(params[:registration_id])
  end

  def create
    @registration = Registration.find(params[:registration_id])
    @headhunter = current_headhunter
    @candidate = @registration.candidate
    @proposal = @registration.create_proposal(proposals_params)
    redirect_to registration_proposals_path, notice: 'Proposta enviada!'
  end

  private

  def proposals_params
    params.require(:proposal).permit(:start_date, :workload, :benefits,
                                     :wage, :details).merge(candidate_id: @candidate.id)

  end
end
