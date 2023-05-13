class CreateBlackListCpfs < ActiveRecord::Migration[7.0]
  def change
    create_table :black_list_cpfs do |t|
      t.string :cpf

      t.timestamps
    end
  end
end
