class HomeController < ApplicationController

  def index
    @headhunters = Headhunter.all
    @vacancies = Vacancy.all
    @candidates = Candidate.all
    @entries = Entry.all
    @proposals = Proposal.all
    if @vacancies.count != 0
      @apply_for_vacancy = (@entries.count)/(@vacancies.count)
    elsif @vacancies.count == 0
      @apply_for_vacancy = 0
    end
    if @entries.count != 0
      @percent_proposal_for_apply = (((@proposals.count).to_f/(@entries.count).to_f)*100).round
    elsif @entries.count == 0
      @percent_proposal_for_apply = 0
    end
  end
end
