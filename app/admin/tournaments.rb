ActiveAdmin.register Tournament do
  permit_params :name, :slug, :tournament_remote_id, :event_remote_id, :remote_participant_count, :rankings_id,
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
end
