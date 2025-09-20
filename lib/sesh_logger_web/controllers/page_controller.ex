defmodule SeshLoggerWeb.PageController do
  use SeshLoggerWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
