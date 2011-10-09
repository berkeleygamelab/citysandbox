class SampleDataEvent < ActiveRecord::Migration
  def up
    Event.create(:title => "Party rocking")
    Event.create(:title => "Bar Party")
    Event.create(:title => "Biker Party")
  end

  def down
  end
end
