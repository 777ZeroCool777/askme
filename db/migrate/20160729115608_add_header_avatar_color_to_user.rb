class AddHeaderAvatarColorToUser < ActiveRecord::Migration
  def change
    add_column :users, :header_avatar_color, :string
  end
end
