defmodule EctoStuff.Db.Models.Base do
  defmacro __using__(_) do
    quote do
      use Ecto.Model
      use Behaviour

      ## Changesets
      def new(params \\ nil) do
        changeset(struct(__MODULE__), params)
      end

      @doc "Generates a changeset for insert or update"
      defcallback changeset(Ecto.Model.t | Ecto.Changeset.t, %{binary => term} | %{atom => term} | nil) :: Ecto.Changeset.t

      defoverridable [new: 1]
    end
  end
end