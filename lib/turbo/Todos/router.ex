defmodule Turbo.Todos.Router do
  @moduledoc false

  use Commanded.Commands.Router

  alias Turbo.Todos.Aggregates.Task
  alias Turbo.Todos.Commands.CreateTask

  alias Turbo.Middlewares.Validate

  middleware(Validate)
  identify(Task, by: :task_uuid, prefix: "task-")
  dispatch([CreateTask], to: Task)
end
