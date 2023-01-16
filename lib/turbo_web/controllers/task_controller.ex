defmodule TurboWeb.TaskController do
  @moduledoc false

  use TurboWeb, :controller

  alias Turbo.Todos.Projections.Task

  alias Turbo.Todos

  action_fallback __MODULE__.Fallback

  @doc false
  def new(conn, _) do
    render(conn, "new.html", changeset: Task.creation_changeset(%{}))
  end

  @doc false
  def create(conn, %{"task" => params}) do
    with {:ok, task} <- Todos.create_task(params) do
      conn
      |> put_flash(:info, "Task successfully created")
      |> redirect(to: Routes.task_path(conn, :show, task))
    end
  end

  @doc false
  def show(conn, %{"uuid" => uuid}) do
    with {:ok, task} <- Todos.task_by_uuid(uuid) do
      conn
      |> render("show.html", task: task)
    end
  end

  @doc false
  def index(conn, _) do
    render(conn, "list.html", tasks: Todos.all_tasks())
  end
end
