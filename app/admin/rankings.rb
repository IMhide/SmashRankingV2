ActiveAdmin.register Ranking do
  permit_params :name

  sidebar 'Tier List' do
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
            column :name
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
end
