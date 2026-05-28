class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  def index
    @appointments = policy_scope(Appointment).includes(:pet, :vet)
  end

  def show
    @appointment = Appointment.includes(:pet, :vet, treatments: :rich_text_clinical_notes).find(params[:id])
    authorize @appointment
  end

  def new
    @appointment = Appointment.new
    authorize @appointment
  end

  def create
    @appointment = Appointment.new(appointment_params)
    apply_role_assignment(@appointment)
    authorize @appointment

    if @appointment.save
      redirect_to @appointment, notice: "Appointment created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @appointment
  end

  def update
    @appointment.assign_attributes(appointment_params)
    apply_role_assignment(@appointment)
    authorize @appointment

    if @appointment.save
      redirect_to @appointment, notice: "Appointment updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @appointment
    @appointment.destroy
    redirect_to appointments_path, notice: "Appointment deleted successfully."
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(policy(@appointment || Appointment.new).permitted_attributes)
  end

  def apply_role_assignment(appointment)
    if current_user.vet?
      appointment.vet = current_user.vet
    elsif current_user.owner?
      appointment.pet = current_user.owner.pets.find_by(id: appointment.pet_id)
    end
  end
end