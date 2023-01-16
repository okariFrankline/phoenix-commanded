defmodule Turbo.Todos do
  @moduledoc false

  alias Turbo.Todos.Commands.{CreateTask, UpdateTask}

  alias Turbo.Todos.Queries.{EntityByUuid, TaskByUuid}

  alias Turbo.Todos.Projections.Task

  @doc """
  Creates a new task given the parameters
  """
  @spec create_task(params :: map) ::
          {:ok, Task.t()} | {:error, :validation_errors, errors :: term}
  def create_task(params) do
    params
    |> CreateTask.new()
    |> CreateTask.put_uuid()
    |> then(&dispatch_command(&1, &1[:task_uuid]))
  end

  @doc """
  Updates a given task
  """
  @spec update_task(uuid :: String.t(), params :: map()) ::
          {:ok, Task.t()} | {:error, :not_found} | {:error, :validation_errors, errors :: term}
  def update_task(uuid, params) do
    with {:ok, _task} <- task_by_uuid(uuid) do
      params
      |> UpdateTask.new()
      |> UpdateTask.put_uuid(uuid)
      |> then(&dispatch_command(&1, &1[:task_uuid]))
    end
  end

  @doc """
  Returns a task idenitified by a given uuid
  """
  @spec task_by_uuid(uuid :: String.t()) :: {:ok, Task.t()} | {:error, :not_found}
  def task_by_uuid(uuid) do
    query = TaskByUuid.new(uuid)

    case Turbo.Repo.one(query) do
      nil -> {:error, :not_found}
      task -> {:ok, task}
    end
  end

  @doc """
  Returns all the created tasks
  """
  @spec all_tasks() :: [Task.t()] | []
  def all_tasks, do: Turbo.Repo.all(Task)

  defp dispatch_command(cmd, uuid, projection \\ Task) do
    with :ok <- Turbo.dispatch(cmd, consistency: :strong),
         query <- EntityByUuid.new(projection, uuid),
         do: {:ok, Turbo.Repo.one!(query)}
  end
end
