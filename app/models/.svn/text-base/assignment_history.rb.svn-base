class AssignmentHistory < ActiveRecord::Base
  belongs_to :item
  belongs_to :project
  belongs_to :user_making_qoute, :class_name => 'User', 
                :foreign_key => :user_making_qoute_id
end
