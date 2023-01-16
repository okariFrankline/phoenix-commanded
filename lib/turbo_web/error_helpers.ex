defmodule TurboWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """
  use Phoenix.HTML

  alias Ecto.Changeset

  @doc """
  Generates tag for inlined form input errors.
  """
  def error_tag(form, field) do
    if error = form.errors[field] do
      content_tag(:span, translate_error(error), class: "text-red-500 text-xs")
    end
  end

  @doc """
  Translates an error message using gettext.
  """
  def translate_error(%Changeset{} = changeset) do
    Changeset.traverse_errors(changeset, &translate_error/1)
  end

  # def translate_error({msg, opts}) do
  #   # Because error messages were defined within Ecto, we must
  #   # call the Gettext module passing our Gettext backend. We
  #   # also use the "errors" domain as translations are placed
  #   # in the errors.po file. On your own code and templates,
  #   # this could be written simply as:
  #   #
  #   #     dngettext "errors", "1 file", "%{count} files", count
  #   #
  #   Gettext.dngettext(TurboWeb.Gettext, "errors", msg, msg, opts[:count])
  # end

  def translate_error({msg, opts}) do
    String.replace(msg, "%{count}", to_string(opts[:count]))
  end

  # def translate_error(msg) do
  #   Gettext.dgettext(TurboWeb.Gettext, "errors", msg)
  # end

  def translate_error(msg), do: msg
end
