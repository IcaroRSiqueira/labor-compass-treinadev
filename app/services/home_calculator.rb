class HomeCalculator
  @headhunters = Headhunter.all
  @candidates = Candidate.all
  @vacancies = Vacancy.all
  @entries = Entry.all
  @proposals = Proposal.all

  def self.headhunters_count
    @headhunters.count
  end

  def self.candidates_count
    @candidates.count
  end

  def self.avaiable_vacancies_count
    @vacancies.avaiable.count
  end

  def self.number_of_applies_for_vacancies
    if @vacancies.count != 0
      @entries.count / @vacancies.count
    elsif @vacancies.count.zero?
      0
    end
  end

  def self.percentage_of_proposals_from_apllies
    if @entries.count != 0
      (@proposals.count.to_f / @entries.count * 100).round
    elsif @entries.count.zero?
      0
    end
  end
end
