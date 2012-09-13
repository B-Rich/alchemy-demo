# This migration comes from alchemy (originally 20120831135441)
class SetAlchemyLanguagesCountryCodeDefaultToEmptyString < ActiveRecord::Migration
  def up
    change_column :alchemy_languages, :country_code, :string, :default => '', :null => false
  end

  def down
    change_column :alchemy_languages, :country_code, :string, :default => nil, :null => true
  end
end
