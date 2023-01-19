defmodule TurboWeb.StimulusController do
  @moduledoc false

  use TurboWeb, :controller

  @doc false
  def counter(conn, _) do
    render(conn, "counter.html")
  end
end
