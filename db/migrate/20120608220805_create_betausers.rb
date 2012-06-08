class CreateBetausers < ActiveRecord::Migration
  def change
    create_table :betausers do |t|

      t.timestamps
    end
  end
end
