ActiveAdmin.register Tournament do
  actions :all, except: %i[new edit update create]
  permit_params :name, :slug, :tournament_remote_id, :event_remote_id, :remote_participant_count, :ranking_id,
                :dated_at

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
    #     transaction =  Tournaments::CheckFinishedTournament.(slug: params[:tournament][:slug])
    #      if transaction.success
    #       flash[:notice] = "Ca marche"
    #       redirect_to admin_tournaments_path
    #     else
    #       flash[:error] = transaction.failure[:error].join(',')
    #       redirect_to add_by_url_admin_tournaments_path
    #     end
  end
end
