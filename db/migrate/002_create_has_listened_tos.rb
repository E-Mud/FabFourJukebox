migration 2, :create_has_listened_tos do
  up do
    create_table :has_listened_tos do
      column :id, Integer, :serial => true
      
    end
  end

  down do
    drop_table :has_listened_tos
  end
end
