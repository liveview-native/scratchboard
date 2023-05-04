defmodule Scratchboard.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Scratchboard.Repo

  schema "posts" do
    field :body, :string
    field :color, :string
    field :font_weight, Ecto.Enum, values: ~w(black bold heavy light medium regular semibold thin ultra_light)a

    timestamps()
  end

  @colors [
    "#eadb91",
    "#e0ad06",
    "#b52e27",
    "#aa71c4",
    "#4d329e",
    "#2d5f91",
    "#7dceaf",
    "#7fad29",
    "#2e7034"
  ]

  @font_weights ~w(
    black
    bold
    heavy
    light
    medium
    regular
    semibold
    thin
    ultra_light
  )a

  @required_fields ~w(body)a
  @optional_fields ~w(color font_weight)a
  @allowed_fields @required_fields ++ @optional_fields

  def changeset(post, attrs) do
    post
    |> cast(attrs, @allowed_fields)
    |> validate_required(@required_fields)
  end

  @doc """
  Create a Post from a body, color, and font_weight.
  The color and font_weight are optional and will be
  randomly selected if not provided.
  """
  def create(body, color \\ nil, font_weight \\ nil) do
    %__MODULE__{}
    |> changeset(%{
      body: body,
      color: color || Enum.random(@colors),
      font_weight: font_weight || Enum.random(@font_weights)
    })
    |> Repo.insert()
  end
end
