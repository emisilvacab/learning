defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Make a guess:", random_number: Enum.random(1..10))}
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    num = socket.assigns.random_number
    guess_int = String.to_integer(guess)
    if guess_int == num do
       message = "Your guess: #{guess}. RIGHT. Guess again "
       score = socket.assigns.score + 1
       {:noreply, assign(socket, score: score, message: message, random_number: Enum.random(1..10))}
    else
      message = "Your guess: #{guess}. Wrong. Guess again. "
      score = socket.assigns.score - 1
      {:noreply, assign(socket, score: score, message: message)}
    end
  end

  #Liveview va a tomar @score y lo va a cambiar por el valor de socket.assigns.message
  #HEEx va a evaluar la expresion y reemplazarla por el resultado y lo mismo para @score
  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
      It's <%= time() %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number={n}><%= n %></a>
      <% end %>
    </h2>
    """
  end
  #No re-renderiza el tiempo ya que no le dimos ninguna manera de determinar que el
  #valor cambia y debe ser re-renderizado, lo podemos hacer con un timer
  def time() do
    DateTime.utc_now |> DateTime.truncate(:second) |> to_string
  end
end
