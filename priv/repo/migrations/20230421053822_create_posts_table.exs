defmodule Scratchboard.Repo.Migrations.CreatePostsTable do
  use Ecto.Migration

  def change do
    create table("posts") do
      add :body, :text
      add :color, :string
      add :font_weight, :string

      timestamps()
    end
  end
end
