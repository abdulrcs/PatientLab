class CreatePatientLabs < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_labs do |t|
      t.datetime :date_of_test
      t.string :id_number
      t.string :patient_name
      t.string :gender
      t.date :date_of_birth
      t.string :phone_mobile
      t.string :lab_number
      t.string :clinic_code
      t.string :code
      t.string :name
      t.string :value
      t.string :unit
      t.string :ref_range
      t.string :finding
      t.string :result_state

      t.timestamps
    end
  end
end
