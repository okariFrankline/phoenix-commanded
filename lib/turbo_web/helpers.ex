defmodule TurboWeb.Helpers do
  @moduledoc """
  Helper functions that will be made available in all controllers
  """
  import Plug.Conn, only: [get_req_header: 2]

  alias Ecto.Changeset

  @doc """
  Given validation errors returned from middlewares, it changes it
  into changeset errors for easier rendering in templates

  The function passed should return a changeset as it's result
  """
  @spec validation_errors(fun :: (() -> Changeset.t()), errors :: map) :: Changeset.t()
  def validation_errors(fun, errors) when is_function(fun, 0) do
    fun.()
    |> Map.put(:errors, errors)
    |> Map.put(:action, :validate)
  end

  @doc """
  Given a Plug.Conn, it returns whether or not it's a turbo frame request
  """
  @spec is_turbo_frame_request?(conn :: Plug.Conn.t()) :: true | false
  def is_turbo_frame_request?(conn) do
    case get_req_header(conn, "turbo-frame") do
      [] -> false
      _ -> true
    end
  end

  @doc """
  Returns the turbo frame id from the conn, if the request is
  """
  @spec turbo_frame_id(conn :: Plug.Conn.t()) :: String.t()
  def turbo_frame_id(conn) do
    if id = frame_id(conn), do: id, else: ""
  end

  defp frame_id(conn) do
    conn
    |> get_req_header("turbo-frame")
    |> List.first()
  end
end
