require 'date'
require 'json'
class PatientLabController < ApplicationController
  def index
    render json: PatientLab.all
  end

  def create
    patient_lab = PatientLab.new(params_parser)
    if patient_lab.save
      render json: patient_lab, status: :created
    else
      render json: patient_lab.errors, status: :unprocessable_entity
    end
  end
  private

  def params_parser
    patientLab = Hash.new
    patientLab[:date_of_test] = DateTime.parse(params[:date_of_test])
    if params.keys.include?("patient_data")
      x = params[:patient_data]
      patientLab[:id_number] = x["id_number"]
      patientLab[:patient_name] = x["first_name"] + ' ' + x["last_name"]
      patientLab[:gender] = x["gender"]
      begin
        patientLab[:date_of_birth] = Date.parse(x["date_of_birth"])
      rescue
        patientLab[:date_of_birth] = nil
      end
      patientLab[:phone_mobile] = x["phone_mobile"]
    else
      x = params
      patientLab[:id_number] = x[:id_number]
      patientLab[:patient_name] = x[:patient_name]
      patientLab[:gender] = x[:gender]
      begin
        patientLab[:date_of_birth] = Date.parse(x[:date_of_birth])
      rescue
        patientLab[:date_of_birth] = nil
      end
      patientLab[:phone_mobile] = x[:phone_mobile]
    end
    x = params
    patientLab[:lab_number] = x[:lab_number]
    patientLab[:clinic_code] = x[:clinic_code]
    x = params["lab_studies"][0]
    patientLab[:code] = x["code"]
    patientLab[:name] = x["name"]
    patientLab[:value] = x["value"]
    patientLab[:unit] = x["unit"]
    patientLab[:ref_range] = x["ref_range"]
    patientLab[:finding] = x["finding"]
    patientLab[:result_state] = x["result_state"]
    return patientLab
  end
end
