class CreateFeedbacks < ActiveRecord::Migration[8.0]
  def change
    create_table :feedbacks do |t|
      t.timestamps
      t.string :name
      t.integer :rating
      t.text :positive_feedback
      t.text :negative_feedback
      t.string :how_did_you_hear
      t.string :how_did_you_hear_other
    end
  end
end
