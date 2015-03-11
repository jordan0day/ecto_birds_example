defmodule EctoStuff.Db.Models.Bird do
  use EctoStuff.Db.Models.Base

  schema "birds" do
    field :name,      :string
    field :size,      :string
    field :call_type, :string, default: "other"
  end

  def changeset(bird, params \\ nil) do
    bird
    |> cast(params, ~w(name size), ~w(call_type))
    |> validate_inclusion(:size, ["tiny", "small", "medium", "large", "giant"])
    |> validate_inclusion(:call_type, ["chirp", "tweet", "hoot", "other"])
  end
end