require 'rails_helper'

describe HomeCalculator do
  describe '.headhunters_count' do
    it 'have none headhunter' do
      result = HomeCalculator.headhunters_count

      expect(result).to be 0
    end

    it 'have one headhunter' do
      create(:headhunter)

      result = HomeCalculator.headhunters_count

      expect(result).to be 1
    end

    it 'have three headhunters' do
      create_list(:headhunter, 3)

      result = HomeCalculator.headhunters_count

      expect(result).to be 3
    end

    it 'have three hundred and fifty headhunters' do
      create_list(:headhunter, 350)

      result = HomeCalculator.headhunters_count

      expect(result).to be 350
    end
  end

  describe '.candidates_count' do
    it 'have none candidate' do
      result = HomeCalculator.candidates_count

      expect(result).to be 0
    end

    it 'have one candidate' do
      create(:candidate)

      result = HomeCalculator.candidates_count

      expect(result).to be 1
    end

    it 'have three candidates' do
      create_list(:candidate, 3)

      result = HomeCalculator.candidates_count

      expect(result).to be 3
    end

    it 'have three hundred and fifty candidates' do
      create_list(:candidate, 350)

      result = HomeCalculator.candidates_count

      expect(result).to be 350
    end
  end

  describe '.avaiable_vacancies_count' do
    it 'have none vacancy' do
      result = HomeCalculator.avaiable_vacancies_count

      expect(result).to be 0
    end

    it 'have one vacancy' do
      create(:vacancy)

      result = HomeCalculator.avaiable_vacancies_count

      expect(result).to be 1
    end

    it 'have three vacancies' do
      create_list(:vacancy, 3)
      create(:vacancy, status: 5)

      result = HomeCalculator.avaiable_vacancies_count

      expect(result).to be 3
    end

    it 'have three hundred and fifty vacancies' do
      create_list(:vacancy, 350)

      result = HomeCalculator.avaiable_vacancies_count

      expect(result).to be 350
    end
  end

  describe 'number_of_applies_for_vacancies' do
    it 'have average of two' do
      vacancy = create(:vacancy)
      create(:entry, vacancy: vacancy)
      create(:entry, vacancy: vacancy)
      vacancy2 = create(:vacancy)
      create(:entry, vacancy: vacancy2)
      create(:entry, vacancy: vacancy2)

      result = HomeCalculator.number_of_applies_for_vacancies

      expect(result).to be 2
    end

    it 'have average of two and a half, but rounds it to two' do
      vacancy = create(:vacancy)
      create(:entry, vacancy: vacancy)
      create(:entry, vacancy: vacancy)

      vacancy2 = create(:vacancy)
      create(:entry, vacancy: vacancy2)
      create(:entry, vacancy: vacancy2)
      create(:entry, vacancy: vacancy2)

      result = HomeCalculator.number_of_applies_for_vacancies

      expect(result).to be 2
    end

    it 'have average of zero' do
      result = HomeCalculator.number_of_applies_for_vacancies

      expect(result).to be 0
    end
  end

  describe '.percentage_of_proposals_from_apllies' do
    it 'have average of fifty' do
      entry = create(:entry)
      entry2 = create(:entry)
      entry3 = create(:entry)
      entry4 = create(:entry)
      create(:proposal, entry: entry)
      create(:proposal, entry: entry2)

      result = HomeCalculator.percentage_of_proposals_from_apllies

      expect(result).to be 50
    end

    it 'have average of thirty three dot three' do
      entry = create(:entry)
      entry2 = create(:entry)
      entry3 = create(:entry)

      create(:proposal, entry: entry)

      result = HomeCalculator.percentage_of_proposals_from_apllies

      expect(result).to be 33
    end

    it 'have average of zero' do
      result = HomeCalculator.percentage_of_proposals_from_apllies

      expect(result).to be 0
    end
  end
end
