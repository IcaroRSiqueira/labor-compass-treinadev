class ProfilesController < ApplicationController

  def show
    @profile = Profile.find(params[:id])

  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.candidate = current_candidate
    if @profile.save
      current_candidate.complete!
      redirect_to @profile, notice: 'Perfil cadastrado com sucesso!'
    else
      render :new
    end
  end

private

  def profile_params
    params.require(:profile).permit(:full_name, :social_name, :birth_date,
                                    :education, :description, :experience,
                                    :avatar)
  end

end
