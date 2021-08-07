ActiveAdmin.register Ranking do
  permit_params :name, :previous_season_id

  sidebar 'Tier List', only: :show do
    attributes_table_for resource.tier_list do
      row :ss_coef
      row :s_coef
      row :a_coef
      row :b_coef
      row :c_coef
    end
  end

  index do
    id_column
    column :name
    actions
  end

  show do
    attributes_table do
      row :compute_state do |t|
        status_tag(t.compute_state, class: t.sync_status_tag_class)
      end
    end
    columns do
      column do
        panel 'Tournois' do
          table_for resource.tournaments.order(:dated_at) do
            column :name do |t|
              link_to t.name, admin_tournament_path(t)
            end
            column :dated_at
            column :tier
            column :match_sync do |t|
              status_tag(t.match_sync, class: t.sync_status_tag_class)
            end
          end
        end
      end
      column do
        panel 'Classement' do
          table_for resource.formated_standing do
            column :position
            column :name
            column :score
            column :match_count
          end
        end
      end
    end
  end

  member_action :calculate_rating, method: :post do
    resource.update(compute_state: :running)
    ComputeRatingWorker.perform_async(resource.id)
    flash[:notice] = 'Calcule du PR programmé'
    redirect_to admin_ranking_path(resource.id)
  end

  action_item :calculate_rating, only: :show do
    link_to 'Calculer le ranking', calculate_rating_admin_ranking_path(resource), method: :post
  end
end
