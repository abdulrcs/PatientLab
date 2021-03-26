class PatientLab < ApplicationRecord
  validates :id_number, :patient_name, :date_of_birth, :date_of_test,  presence: true
end
