defmodule Turbo.Todos.Projectors.Task do
  @moduledoc false

  use Commanded.Event.Handler,
    name: __MODULE__,
    application: Turbo,
    consistency: :strong,
    start_from: :origin

  alias Ecto.Multi

  alias Turbo.Todos
  alias Turbo.Todos.Events.{TaskCreated, TaskUpdated}
  alias Turbo.Todos.Projections.Task

  require Logger

  @new_multi Multi.new()

  @doc false
  def handle(%TaskCreated{task_uuid: uuid} = event, _) do
    changes =
      event
      |> Map.from_struct()
      |> Map.put_new(:uuid, uuid)

    @new_multi
    |> Multi.insert(:task, Task.creation_changeset(changes))
    |> process_transaction(:task)
  end

  def handle(%TaskUpdated{task_uuid: uuid} = event, _) do
    changes = Map.from_struct(event)

    @new_multi
    |> Multi.run(:task, fn _, _ -> Todos.task_by_uuid(uuid) end)
    |> Multi.run(:updated_task, fn _, %{task: task} -> Task.changeset(task, changes) end)
    |> process_transaction(:updated_task)
  end

  @doc false
  def error({:error, reason}, event, _) do
    Logger.warn("""
    Projection of the event #{inspect(event)} failed with reason #{inspect(reason)}
    """)

    :skip
  end

  defp process_transaction(multi, field) do
    # this function processes the transaction by
    # commiting it using Repo and then returns the
    # {:ok, value} where value is identified by the field
    # if successful
    case Turbo.Repo.transaction(multi) do
      {:ok, results} -> {:ok, results[field]}
      {:error, _, reason, _} -> {:error, reason}
    end
  end
end
