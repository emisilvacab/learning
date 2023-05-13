#Entramos desde navigate() le podemos pasar . y lo convierte en un path completo mediante expand
#iex(56)> Path.expand(".")
#"/Users/emiliano/mimiquate/1lfwe/4"
#Llama a go_through para meterse en el path completo

#a go_through le llega una lista de rutas completas todas dentro de un directorio
#En esta funcion si tenemos un directorio vacio no hacemos nada
#de lo contrario usa recursion printear el directorio y meterse dentro de content (si es un directorio) mediante print_and_navigate

#a print_and_navigate se le envia una ruta y un booleano que dice si es un directorio
#si lo es printea la ruta y hace ls dentro para conseguir sus hijos
#hace go_through nuevamente, consiguiendo la lista de los hijos mediante expand_dirs

#a expand_dirs le envian quien es el padre y la lista de los hijos pero no con la ruta completa si no que a partir del padre
#expand combina las rutas
defmodule Navigator do
  def navigate(dir) do
    #transforma dir en un path completo
    expanded_dir = Path.expand(dir)
    go_through([expanded_dir])
  end

  #un directorio vacio
  defp go_through([]), do: nil
  #un directorio con al menos content
  defp go_through([content | rest]) do
    #File.dir? es true si content es un directory
    print_and_navigate(content, File.dir?(content))
    go_through(rest)
  end

  #Si dir no es un directory
  defp print_and_navigate(_dir, false), do: nil
  defp print_and_navigate(dir, true) do
    IO.puts dir
    #listo los contenidos de dir
    children_dirs = File.ls!(dir)
    #me meto en los directorios hijos (contenido de dir)
    go_through(expand_dirs(children_dirs, dir))
  end

  #en el primer parametro los directorios hijos en el segundo el padre
  #si no hay nada en el hijo no agrego nada
  defp expand_dirs([], _relative_to), do: []
  #si al menos hay algo en el hijo
  defp expand_dirs([dir | dirs], relative_to) do
    #transforma dir en un path completo, a partir del padre (relative_to)
    expanded_dir = Path.expand(dir, relative_to)
    [expanded_dir | expand_dirs(dirs, relative_to)]
  end
end
#se mete infinitamente en los hijos por lo que podemos hacer una version acotada por la altura depth_navigator
