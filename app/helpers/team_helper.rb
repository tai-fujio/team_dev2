module TeamHelper
  def default_img(image)
    image.presence || 'default.jpg'
  end

  def first_game
    return if User.current_user.nil?
    begin
      User.current_user.assigns.create!(team_id: Team.first.id) if current_user.teams.blank?
    rescue => e
      Team.create(
        name: 'First Team!'
        owner_id: User.current_user.id
      )
      User.current_user.assigns.create!(team_id: Team.first.id) if current_user.teams.blank?
    end
  end
end
