defmodule Turbo.Todos.Router do
  @moduledoc false

  use Commanded.Commands.Router

  alias Turbo.Todos.Aggregates.Task
  alias Turbo.Todos.Commands.{CreateTask, UpdateTask}

  alias Turbo.Middlewares.Validate

  middleware(Validate)
  identify(Task, by: :task_uuid, prefix: "task-")

  dispatch([CreateTask, UpdateTask], to: Task)
end
