ActiveAdmin.register Tournament do
  actions :all, except: %i[new edit update create]
  permit_params :slug, :ranking_id

  index do
    id_column
    column :name
    column :slug
    column :dated_at
    column :ranking
    actions
  end

  filter :name
  filter :slug
  filter :dated_at

  action_item :add_by_url, only: :index do
    link_to 'Ajouter un tournois', add_by_url_admin_tournaments_path
  end
  collection_action :add_by_url do; end

  collection_action :create_by_url, method: :post do
    tournament = CreateTournamentBySlug.new(tournament: Tournament.new(resource_params.first)).call
    if tournament
      flash[:notice] = 'Ca marche'
      redirect_to admin_tournament_path(tournament)
    else
      flash[:error] = 'Le tournois fourni est invalide'
      redirect_to add_by_url_admin_tournaments_path
    end
  end
end
