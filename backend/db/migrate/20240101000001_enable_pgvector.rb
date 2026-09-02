# No-op: was PostgreSQL pgvector extension — not needed for MySQL
class EnablePgvector < ActiveRecord::Migration[7.2]
  def up; end
  def down; end
end
