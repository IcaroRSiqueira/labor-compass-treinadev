class ReportsController < ApplicationController

  def positive
    @proposals = Proposal.all
    @proposal = Proposal.find(params[:id])
    @report = @proposal.create_report(report_params)
    @report.save!
    @proposals.each { |p| p.refused! }
    @proposal.accepted!
    redirect_to entry_proposals_path(current_candidate), notice: 'Parabéns, você aceitou a proposta e já tem um novo emprego!'
  end

  def negative
    @proposal = Proposal.find(params[:id])
    @report = @proposal.create_report(report_params)
    @report.save!
    @proposal.refused!
    redirect_to entry_proposals_path(current_candidate), notice: 'Proposta rejeitada com sucesso'
  end

  private

  def report_params
    params.require(:report).permit(:body)
  end
end
