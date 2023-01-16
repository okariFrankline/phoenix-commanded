defmodule Turbo.Todos.Aggregates.Task do
  @moduledoc false

  defstruct [
    :task_uuid,
    :title,
    :due_date
  ]

  @type t :: %__MODULE__{
          title: String.t(),
          due_date: Date.t(),
          task_uuid: String.t()
        }

  alias Turbo.Todos.Commands.{CreateTask, UpdateTask}
  alias Turbo.Todos.Events.{TaskCreated, TaskUpdated}

  @doc false
  def execute(%__MODULE__{task_uuid: nil}, %CreateTask{} = cmd) do
    cmd
    |> Map.from_struct()
    |> TaskCreated.new()
  end

  def execute(%__MODULE__{}, %UpdateTask{} = cmd) do
    cmd
    |> Map.from_struct()
    |> TaskUpdated.new()
  end

  @doc false
  def apply(%__MODULE__{} = task, %TaskCreated{} = event) do
    %__MODULE__{task | title: event.title, task_uuid: event.task_uuid, due_date: event.due_date}
  end

  def apply(%__MODULE__{task_uuid: uuid} = task, %TaskUpdated{task_uuid: uuid} = event) do
    %__MODULE__{task | title: event.title, due_date: event.due_date}
  end
end
