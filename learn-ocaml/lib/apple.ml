open! Base

module Color = struct
  type t =
   | Red
   | Gold [@@deriving sexp_of]
end

type t = { location : Position.t; color : Color.t } [@@deriving sexp_of]

let location t = t.location

let color t = t.color

let amount_to_grow t =
  match color t with
  | Red | Gold -> 2
;;

(* Exercise 05:

   [create] takes in a board and a snake and creates a new apple with a location chosen
   randomly from all possible locations inside the board that are not currently occupied
   by the snake. If there is no location possible it should return None. (This will
   happen if the player wins!)

   We have used records before, but creating the apples location is the first time we'll
   need to make a new one. We can define a record like so:

   {[
     { field_name1 = value1
     ; field_name2 = value2
     }
   ]}

   One function you might find handy for this exercise is [Board.all_locations], which is
   defined in board.ml. [Board.all_locations] takes a board and returns a list of all
   positions on the board.

   Another function that may be useful is [Snake.all_locations], which is defined in
   snake.ml. This function takes a snake and returns all locations it currently occupies.

   Before you get started, check out LIST_FUNCTIONS.mkd for some useful new List
   functions. You probably won't need all of these functions, but they should give you a
   few options for how to write [create].

   You may feel like your solution to this function is inefficient. That's perfectly fine,
   since the board is quite small. Talk to a TA if you'd like to learn other tools that
   might help make this function more efficient.

   When you're done writing [create], make sure to check that tests pass by running

   $ test/exercise05/inline_test_runner *)
let create ~board ~snake =
  match
    (List.filter (Board.all_locations board) ~f:(fun x -> not (List.mem (Snake.all_locations snake) x ~equal:Position.equal)))
  with
  | [] -> None
  | xs -> Some {location = List.random_element_exn xs; color = List.random_element_exn [Color.Red; Color.Gold]}
;;

module Exercises = struct
  let exercise05                    = create
  let create_with_location location = { location; color = List.random_element_exn [Color.Red; Color.Gold] }
end
