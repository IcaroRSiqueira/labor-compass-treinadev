class ProfilesController < ApplicationController
  before_action :authenticate_candidate!

  def show
    @profile = Profile.find(params[:id])

  end

  def new
    @profile = Profile.new
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      flash[:notice] = 'Perfil alterado com sucesso!'
      redirect_to @profile
    else
      render :edit
    end
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
