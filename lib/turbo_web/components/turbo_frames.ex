defmodule TurboWeb.TurboFrames do
  @moduledoc """
  Defines all the component functions that will be turbo-frame responses
  """

  use Phoenix.Component

  @doc """
  Returns a response for displaying the details for a given task
  """
  attr(:task, :map, required: true)

  def task_create_frame(assigns) do
    ~H"""
    <turbo-frame id="task-create">
      <div class="w-full max-w-4xl mx-auto px-4">
        <h2> Task details </h2>

        <p> Title: <%= @task.title %> </p>
        <p> Due date: <%= @task.due_date %> </p>
      </div>
    </turbo-frame>
    """
  end
end
