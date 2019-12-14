class Admin < ApplicationRecord
  belongs_to :school

  before_save {self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {minimum: 3, maximum: 60}
  validates :email, presence: true, uniqueness: {case_sensitive: false},
            length: {maximum: 320}, format: {with: VALID_EMAIL_REGEX}
  validates :school, presence: true

  #def school_id=(val)
  #  logger.debug ("School is " + :school_id + ", and " + School.find_by_name(:school))
  #  write_attribute(:school_id, School.find_by_name(:school_id))
  #end

end
