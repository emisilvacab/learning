#Inmutabilidad-------------------------------------------------------------------------------------
x = 3
x = 4
IO.puts x #-> 3

#Atom---------------------------------------------------------------------------------------------
#Constante cuyo valor es su nombre
:ok
:error

#Operators----------------------------------------------------------
a&&b -> returnea b si a es true, returnea a y si a es false
a||b -> returnea el primero que sea true, si no hay true da el último
or -> entre booleans
|| -> entre valores: false y nil (F), todo lo demas incluso 0 (T)

1 == 1.0 #True, igualdad de valores
1 === 1.0 #False, igualdad estricta

#Strings--------------------------------------------------------------------------------------------
d = "dias"
"Hola" <> "buenos #{d}"
String.at(d, 0) == "d"

#Strings ""
#Char list ''

#Default value--------------------------------------------------------------------------------------

def fun(a, b \\ 1), do: a + b
#Si no pasan b entonces b = 1 en vez de hacer
#no se hace en anónimas
def fun_2(a, b), do: a + b
def fun_2(a), do: a + 1

#Ignore value---------------------------------------------------
def g(a, _), do: a
#O
def h(a, _b) do: a

#Sigils--------------------------------------------------------------------------------------------

names = ~w(Jorge Julio Ana)#== ["Jorge", "Julio", "Ana]
year = 2023
month = 05
day = 12
date = ~D[year-month-day]

#Colecciones:
  #Enumerables-------------------------------------------------------------------------------------
  map = %{atribute_1: 123, atribute_2: "aaa"}
  #keys son atoms en este caso pero pueden ser integers, strings,
  #map[:atribute_1]-> 123
  list = [1,2,3] ++ [4,5,6 | 7,8,9]
  list_2 = [head | tail]
  #list_a ++ list_b -> list
  #list_a -- list_b -> list
  #a in list_a -> true/false
  range = 1..100

  #keyword list-------------------------------------------------------------------------------------
  #Se usa en only cuando hacemos import para distintas
  # aridades de la misma funcion
  [a:1, a:12]


  #Tulpas----------------------------------------------------------------------------------------------
  tuple = {1,2,3}
  tuple = {[1,3,5], [2,4,6]}

#Atributo de modulo----------------------------------------------------------------------------------
@max 2
1 + @max == 3

#Funciones anónimas----------------------------------------------------------------------------------

mult_2 = fn n -> n * 2 end
mult_2.(1) == 2

sum = &(&1 + &2)#&1 = primer parametro
sum = &(&1 + &2 + &3)# sum.()/3 <-aridad 3

#import---------------------------------------------------------------------------------------------

alias Mix.Shell.IO, as: Shell
Shell.cmd("clear")
Shell.info("Hola")
#Para usar .. , as: Esto
Shell.prompt("Press Enter to continue...")

import Enum
#Para usar funciones de Enum sin tener que poner previamente Enum.

import String, only[pad_leading:2 pad_leading:3]
#Solo importar esas funciones especificadas con su aridad
#ademas de only[] tambien se puede except[]


#Pattern Matching----------------------------------------------------------------------------------
x = 2
2 = x #out: 2
#Regex y binarypm ...

%{day: dia} = date#12/5/2023
dia#Out: 12

user = %{id: 12, name: "Jorge", capo: true}
user_2 = %{id: 13, name: "Julio", capo: false}

def get_capo(user = %{capo: true}), do: "#{user.name} es capo"
def get_capo(user), do: "#{user.name} no es capo"

def winner({
  a,a,a,
  _,_,_,
  _,_,_
}), do: {:winner, a}
def winner({_,_,_,a,a,a,_,_,_}), do: {:winner, a}
def winner({_,_,_,_,_,_,a,a,a}), do: {:winner, a}

def winner({_,_,a,_,_,a,_,_,a}), do: {:winner, a}
def winner({_,a,_,_,a,_,_,a,_}), do: {:winner, a}
def winner({a,_,_,a,_,_,a,_,_}), do: {:winner, a}

def winner({a,_,_,_,a,_,_,_,a}), do: {:winner, a}
def winner({_,_,a,_,a,_,a,_,_}), do: {:winner, a}

def winner(), do: :no_winner

#when------------------------------------------------------------------------------------------

#Guard Clausses de when deben de ser triviales, simples
#< > <= >= == !=
#Macros (funciones triviales en el core)
#defguard para crear Macro

def greater(first_num, second_num) when first_num >= second_num, do: first_num
def greater(_, second_number), do: second_number

def income_tax(salary) when salary <= 2000, do: 0
def income_tax(salary) when salary <= 3000, do: salary*0.05
def income_tax(salary) when salary <= 6000, do: salary*0.10
def income_tax(salary), do: salary*0.15

#Recursion-------------------------------------------------------------------------------------

#Se hace con named functions, no con anónimas

#Decrease and conquer
#1
#1 + 2
#1 + 2 + 3

#Divide and conquer
#Merge-Sort

#Tail-recursion + optimo (usar acumulador)
def of(n), do: factorial_of(n,1)
defp factorial_of(0, acc), do: acc
defp factorial_of(n, acc), do: factorial_of(n - 1, n * acc)

#Alto orden-------------------------------------------------------------------------------------
#Funciones con funciones como parámetros y/o returnean funciones
def each([], _function), do: nil
def each([head | tail], function) do
  function.(head)
  each(tail, function)
end

def map([], _function), do: []
def map([head | tail], function) do
  [function.(head) | map(tail, function)]
end

def reduce([], acc, _function), do: acc
def reduce([head | tail], acc, function) do
  reduce(tail, function.(head, acc), function)
end

def filter([], _function), do: []
def filter([head | tail], function) do
  if function.(head) do
    [head | filter(tail, function)]
  else
    filter(tail, function)
  end
end

#Enum para manipular collections
#list = Enum.to_list 1..5
#Enum.concat([1,2],[3,4])
#Enum.filter
#map
#filter
#sum
#...

#for ~ comprehension ---------------------------------------------------------------------------

for a <- [1,2], b <- [3,4], do: {a,b}
#[{1,3}, {1,4}, {2,3}, {2,4}]

#Stream-------------------------------------------------------------------------------------
#No se usa de una, se aplica cuando hay problemas de rendimiento con
#Enum se cambia a Stream

Stream.iterate(s, fun)
#Genera secuencia de valores empezando en s sucesivamente
#aplicando fun a valor anterior
Stream.cycle
#Genera secuencia que hace ciclo sobre items del enum
Stream.chunk(n)
#Acuula n items antes de enviar


#Protocols-------------------------------------------------------------------------------------
#Se usa para polimorfismo entre structs
defprotocol A do
  def f(val)
end

defimpl A, for X do
  def info(val), do: ...
end

defimpl A, for Y do
  def info(val), do:...
end

#X e Y son los posibles tipos de val

#Si cuando voy a printear solo quiero que se printee el name
defimpl String.Chars do
  def to_string(character), do: character.name
end

#behaviours---------------------------------------------------------------------------------------------
#Se para crear contratos entre modulos

defmodule A do
  @callback fun(character :: any, Action.t) :: any
end
#Es una function rule
#Debe tener una funcion llamada fun
#con un character de cualquier tipo
#con un Action.t
#returneo cualquier cosa

@behaviour A
#Para indicar que sigue el contrato de A

#Structs y Type specifications-----------------------------------------------------------------------

defmodule Action do
  defstruct id: nil,
            label: nil,
            number: 0

  @type t :: %Action{
              id: atom,
              label: String.t,
              number: non_neg_integer}
end

#Pipe operator |> ------------------------------------------------------------------------------------

#Se hace en orden de izq a derecha
#params |> f1 |> f2 |> .. |> fn

val |> f(a,b) == f(val,a,b)

def ask_number(message) do
  message <> "\n"
    |> IO.gets
    |> Integer.parse
end

# • Get the customer list.
# • Generate a list of their orders.
# • Calculate tax on the orders.
# • Prepare the filing.
# To take this from a napkin spec to running code, you just put |> between the
# items and implement each as a function.

DB.find_customers
  |> Orders.for_customers
  |> sales_tax(2018)
  |> prepare_filing

#Se recorre dos veces items menos eficiente
def enchant_for_sale(items) do
  items
  |> Enum.reject(fn item -> item.magic end)
  |> Enum.map(fn item ->
    %{
      title: "#{@enchanter_name}'s #{item.title}",
      magic: true,
      price: item.price * 3
    }
  end)
end

def enchant_for_sale_for(items) do
  for item <- items, !item.magic do
    %{
      title: "#{@enchanter_name}'s #{item.title}",
      magic: true,
      price: item.price * 3
    }
  end
end

#Se recorre una única vez, usamos enum.map y mediante pm filtramos los que queremos
def enchant_for_sale_for_22(items) do
  Enum.map(items, &(enchant(&1)))
end

def enchant(%{magic: false} = item) do
  %{
    title: "#{@enchanter_name}'s #{item.title}",
    magic: true,
    price: item.price * 3
  }
end

def enchant(item), do: item


#Mix--------------------------------------------------------------------------------------------------

mix new project_name#Crea carpeta con project_name y proyeto dentro
mix test#Corre tests dentro de carpeta project_name/test
mix start#Ejecuta dungeon_crawl/lib/mix/tasks/start.ex
iex -S mix#flag indica correr un script en ejecucion

#Manejo de errores-------------------------------------------------------------------------------------
#Funciones impuras->resultados inesperados
#se puede usar case, if para casos simples
#try-rescue o throw-raise no se usa, mejor trabajar solo con valores
#Monads fuera de elixir (debo importar) pero simples
#With es lo mejor, haciendo PM

#case
def checkout_1(price) do
  case ask_number("Quantity?") do
    :error -> IO.puts("Invalid number")
    {quantity, _} -> quantity * price
  end
end

#with
def checkout_w2() do
  with {quantity,_} <- ask_number("Quantity?"),
       {price,_} <- ask_number("Price?") do
    quantity * price
  else
    :error ->
      IO.puts "Invalid number"
  end
end

#Se puede usar when en el with
with {option,_} <- Integer.parse(answer),
  chosen when chosen != nil <- Enum.at(options, option - 1) do
    chosen
else
  :error -> retry(options)
  nil -> retry(options)
end

#Debugging-------------------------------------------------------------------------------------

options
  <| Enum.map(a)
  <| IO.inspect(label: "luego de map")#Nos printea y no corta ejecucion

dbg()#Frena ejecucion y puedo printear en consola
