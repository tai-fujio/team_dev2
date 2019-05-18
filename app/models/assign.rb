class Assign < ApplicationRecord
  belongs_to :user
  belongs_to :team

  before_destroy :check_destroy

  def check_destroy
    return (
      self.user != self.team.owner &&
      self.user == User.current_user &&
      User.current_user == self.team.owner
    )
  end
end
