class ReshiftResponseTemplates < ActiveRecord::Migration
  def up
    drop_table :response_templates
    create_table :response_templates do |t|
      t.string :response
      t.depth :integer
      t.score :integer
      t.parent_id :integer
      t.user_id :integer
      t.anonymous :boolean
      t.group_response :boolean
      t.timestamps
      end
  end

  def down
  end
end
