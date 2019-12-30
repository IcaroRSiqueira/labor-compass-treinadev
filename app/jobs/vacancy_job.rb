class VacancyJob < ActiveJob::Base

    after_create :set_expiry_timer

    def set_expiry_timer
      delay(:run_at => end_date).expire
    end

    def expire
      update_attribute(status: :finalized) unless finalized?
    end
  end
