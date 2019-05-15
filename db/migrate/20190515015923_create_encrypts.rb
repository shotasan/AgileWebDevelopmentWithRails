class CreateEncrypts < ActiveRecord::Migration[5.2]
  def change
    create_table :encrypts do |t|

      t.timestamps
    end
  end
end
