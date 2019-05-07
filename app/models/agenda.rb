class Agenda < ApplicationRecord
  belongs_to :team
  belongs_to :user
  has_many :articles, dependent: :destroy

  before_destroy :check_authority
  after_destroy :send_delete_agenda_mail

  attr_accessor :target_user

  def check_authority
    target_user == self.user || target_user == self.team.owner
  end

  def send_delete_agenda_mail
    self.team.assigns.each do |assign|
      email = assign.user.email
      AgendaMailer.agenda_mail(email, self).deliver
    end
  end
end