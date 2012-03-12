class ResponseTemplate < ActiveRecord::Base
	belongs_to :item_template
	belongs_to :responder, :polymorphic => true
end