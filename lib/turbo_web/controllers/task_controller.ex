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
      case get_req_header(conn, "turbo-frame") do
        [] ->
          conn
          |> put_flash(:info, "Task successfully created")
          |> redirect(to: Routes.task_path(conn, :show, task))

        _ ->
          conn
          |> put_flash(:info, "Task successfully created")
          |> render("frames/task_created_frame.html", task: task)
      end
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
  def update_form(conn, %{"uuid" => uuid}) do
    with {:ok, task} <- Todos.task_by_uuid(uuid) do
      conn
      |> render("update.html", changeset: Task.changeset(task), task: task)
    end
  end

  @doc false
  def update(conn, %{"uuid" => uuid, "task" => params}) do
    with {:ok, task} <- Todos.update_task(uuid, params) do
      if is_turbo_frame_request?(conn) do
        conn
        |> render("frames/task_created.html", task: task)
      else
        conn
        |> put_flash(:info, "Task updated successfully")
        |> redirect(to: Routes.task_path(conn, :show, task))
      end
    end
  end

  @doc false
  def list(conn, _) do
    render(conn, "list.html", tasks: Todos.all_tasks())
  end

  @doc false
  def index(conn, _) do
    render(conn, "index.html")
  end
end
