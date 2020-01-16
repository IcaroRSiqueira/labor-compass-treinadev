class ProposalsController < ApplicationController
  before_action :authenticate_headhunter!, only: [:new, :create]
  before_action :authenticate_candidate!, only: [:confirm, :refuse]


  def index
  end

  def new
    @proposal = Proposal.new
    @entry = Entry.find(params[:entry_id])
  end

  def create
    @entry = Entry.find(params[:entry_id])
    if @entry.proposal.nil?
      @headhunter = current_headhunter
      @candidate = @entry.candidate
      @proposal = @entry.create_proposal(proposals_params)
      @proposal.avaiable!
      redirect_to entry_proposals_path, notice: 'Proposta enviada!'
    elsif @entry.proposal.present?
      redirect_to entry_proposals_path, notice: 'Você ja enviou uma proposta para esta aplicação'
    end
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def confirm
    @proposal = Proposal.find(params[:id])
    @report = Report.new
  end

  def refuse
    @proposal = Proposal.find(params[:id])
    @report = Report.new
  end

  private

  def proposals_params
    params.require(:proposal).permit(:start_date, :workload, :benefits,
                                     :wage, :details).merge(candidate_id: @candidate.id, headhunter: current_headhunter)

  end
end
