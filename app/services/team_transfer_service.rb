class TeamTransferService < BaseService
  include ApplicationHelpe

  concerning :TeamBuilder do
    attr_reader :team_id
    def team
      @team ||= Team.friendly.find(team_id)
      @team.owner_id = assign.user.id
    end
  end

  concerning :AssignBuilder do
    attr_reader :id
    def user
        @assign ||= Assign.find(id)
    end
  end

  def transfer
    return false if !validate

    email =

    return TeamMailer.team_mail(email, team.owner.email).deliver && @team.save
  end

  private

  def validate
    @errors = []
    true
  end
end
