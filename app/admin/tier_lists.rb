ActiveAdmin.register TierList do
  permit_params :ss_min, :ss_coef, :s_min, :s_coef, :a_min, :a_coef, :b_min, :b_coef, :c_min, :c_coef, :rankings_id

  index do
    id_column
    column :ranking
    actions
  end

  filter :ranking
end
