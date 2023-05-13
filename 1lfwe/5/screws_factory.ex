defmodule ScrewsFactory do
  def run(pieces) do
    pieces
    |> Stream.chunk(50)
    |> Stream.flat_map(&add_thread/1)#Da un stream flat (si hay listas dentro de listas lo deja todo en una sola) resultado de hacer append de los elementos luego de aplicarles la funcion
    |> Stream.chunk(100)
    |> Stream.flat_map(&add_head/1)
    |> Enum.each(&output/1)
  end
  def run_eager(pieces) do
    pieces
    |> Enum.map(&add_thread/1)
    |> Enum.map(&add_head/1)
    |> Enum.each(&output/1)
  end

  def run_lazy(pieces) do
    pieces
    |> Stream.map(&add_thread/1)
    |> Stream.map(&add_head/1)
    |> Enum.each(&output/1)
  end

  defp add_thread(piece) do
    Process.sleep(50)
    Enum.map(pieces, &(&1 <> "--"))
  end

  defp add_head(piece) do
    Process.sleep(100)
    Enum.map(pieces, &("o" <> &1))
  end

  defp output(screw) do
    IO.inspect(screw)
  end
end
