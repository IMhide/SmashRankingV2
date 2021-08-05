ActiveAdmin.register Ranking do
  permit_params :name

  sidebar 'Tier List', only: :show do
    attributes_table_for resource.tier_list do
      row :ss_coef
      row :s_coef
      row :a_coef
      row :b_coef
      row :c_coef
    end
  end

  show do
    columns do
      column do
        panel 'Tournois' do
          table_for resource.tournaments do
            column :name do |t|
              link_to t.name, admin_tournament_path(t)
            end
            column :dated_at
            column :tier
            column :match_sync
          end
        end
      end
      column do
        panel 'Classement' do
        end
      end
    end
  end

  member_action :calculate_rating, method: :post do
    @ranking.update(compute_state: :running)
    ComputeRatingWorker.perform(resource.id)
    flash[:notice] = 'Calcule du PR programmé'
    redirect_to admin_ranking_path(resource.id)
  end
end
