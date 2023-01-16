defmodule Turbo.Todos.Projections.Task do
  @moduledoc false

  use Ecto.Schema

  alias Ecto.Changeset

  import Changeset

  @type t :: %__MODULE__{
          title: String.t(),
          due_date: Date.t()
        }

  @derive {Phoenix.Param, key: :uuid}
  @primary_key {:uuid, :binary_id, autogenerate: false}
  schema "tasks" do
    field :title, :string
    field :due_date, :date

    timestamps()
  end

  @doc false
  @spec creation_changeset(attrs :: map) :: Changeset.t()
  def creation_changeset(attrs) do
    task = %__MODULE__{}

    task
    |> cast(attrs, [:title, :due_date, :uuid])
    |> validate_required([:title, :due_date, :uuid])
  end

  @doc false
  def changeset(%__MODULE__{} = task, attrs \\ %{}) do
    cast(task, attrs, [:due_date, :title])
  end
end
