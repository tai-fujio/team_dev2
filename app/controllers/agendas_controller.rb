class AgendasController < ApplicationController
  before_action :set_agenda, only: %i[show edit update destroy]

  def index
    @agendas = Agenda.all
  end

  def new
    @team = Team.friendly.find(params[:team_id])
    @agenda = Agenda.new
  end

  def create
    @agenda = current_user.agendas.build(title: params[:title])
    @agenda.team = Team.friendly.find(params[:team_id])
    current_user.keep_team_id = @agenda.team.id
    if current_user.save && @agenda.save
      redirect_to dashboard_url, notice: 'アジェンダ作成に成功しました！'
    else
      render :new
    end
  end

  def destroy
    # byebug
    render :index if current_user != @agenda.user || current_user != @agenda.team.owner

    if @agenda.destroy
      @agenda.team.assigns.each do |assign|
        email = assign.user.email
        AgendaMailer.agenda_mail(email, @agenda).deliver
      end
      redirect_to dashboard_path, notice: "アジェンダ「#{@agenda.title}」を削除しました！"
    else
      render :index
    end
  end

  private

  def set_agenda
    @agenda = Agenda.find(params[:id])
  end

  def agenda_params
    params.fetch(:agenda, {}).permit %i[title description]
  end
end
