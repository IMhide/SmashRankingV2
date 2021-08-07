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
      flash[:notice] = 'Tournois ajouté'
      redirect_to admin_tournament_path(tournament)
    else
      flash[:error] = 'Le tournois fourni est invalide'
      redirect_to add_by_url_admin_tournaments_path
    end
  end

  member_action :add_event, method: :post do
    SyncTournamentEvent.new(tournament: resource, remote_event_id: params[:remote_event_id]).call
    flash[:notice] = 'Event synchronisé'
    redirect_to admin_tournament_path(resource)
  end

  show do
    attributes_table do
      row :name
      row :ranking
      row :dated_at
      row :tier
      row :match_sync
      row :link do |t|
        link_to 'Lien', "https://smash.gg/tournament/#{t.slug}", target: :blank
      end
      row :created_at
    end

    if resource.event_remote_id.nil?
      render 'events_list', {resource: resource}
    else
      render 'participants_list', {resource: resource}
    end

    render 'matches_list', {matches: resource.matches} if resource.match_sync.success?
  end

  sidebar 'Dev informations', only: :show do
    attributes_table do
      row :tournament_remote_id
      row :event_remote_id
    end
  end
end
