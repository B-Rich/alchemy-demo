class FixingAlchemySchema < ActiveRecord::Migration
  def self.up
    execute("UPDATE schema_migrations SET version = '20110529130429-alchemy' WHERE version = '20110429130429-alchemy'")
    execute("UPDATE schema_migrations SET version = '20110529130500-alchemy' WHERE version = '20110429130500-alchemy'")
    execute("UPDATE schema_migrations SET version = '20110530102804-alchemy' WHERE version = '20110430102804-alchemy'")
  end

  def self.down
    execute("UPDATE schema_migrations SET version = '20110429130429-alchemy' WHERE version = '20110529130429-alchemy'")
    execute("UPDATE schema_migrations SET version = '20110429130500-alchemy' WHERE version = '20110529130500-alchemy'")
    execute("UPDATE schema_migrations SET version = '20110430102804-alchemy' WHERE version = '20110530102804-alchemy'")
  end
end
