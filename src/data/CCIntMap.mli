
(* This file is free software, part of containers. See file "license" for more details. *)

(** {1 Map specialized for Int keys}

    {b status: stable}
    @since 0.10 *)

type 'a t

val empty : 'a t

val singleton : int -> 'a -> 'a t

val doubleton : int -> 'a -> int -> 'a -> 'a t

val mem : int -> _ t -> bool

val find : int -> 'a t -> 'a option

val find_exn : int -> 'a t -> 'a
(** Same as {!find} but unsafe
    @raise Not_found if key not present *)

val add : int -> 'a -> 'a t -> 'a t

val remove : int -> 'a t -> 'a t

val equal : eq:('a -> 'a -> bool) -> 'a t -> 'a t -> bool
(** [equal ~eq a b] checks whether [a] and [b] have the same set of pairs
    (key, value), comparing values with [eq]
    @since 0.13 *)

val compare : cmp:('a -> 'a -> int) -> 'a t -> 'a t -> int
(** Total order between maps; the precise order is unspecified .
    @since 0.13 *)

val update : int -> ('a option -> 'a option) -> 'a t -> 'a t

val cardinal : _ t -> int
(** Number of bindings in the map. Linear time *)

val iter : (int -> 'a -> unit) -> 'a t -> unit

val fold : (int -> 'a -> 'b -> 'b) -> 'a t -> 'b -> 'b

val mapi : (int -> 'a -> 'b) -> 'a t -> 'b t
(** @since 0.17 *)

val map : ('a -> 'b) -> 'a t -> 'b t
(** @since 0.17 *)

val choose : 'a t -> (int * 'a) option

val choose_exn : 'a t -> int * 'a
(** @raise Not_found if not pair was found *)

val union : (int -> 'a -> 'a -> 'a) -> 'a t -> 'a t -> 'a t

val inter : (int -> 'a -> 'a -> 'a) -> 'a t -> 'a t -> 'a t

(** {2 Whole-collection operations} *)

type 'a sequence = ('a -> unit) -> unit
type 'a gen = unit -> 'a option
type 'a klist = unit -> [`Nil | `Cons of 'a * 'a klist]

val add_list : 'a t -> (int * 'a) list -> 'a t

val of_list : (int * 'a) list -> 'a t

val to_list : 'a t -> (int * 'a) list

val add_seq : 'a t -> (int * 'a) sequence -> 'a t

val of_seq : (int * 'a) sequence -> 'a t

val to_seq : 'a t -> (int * 'a) sequence

val keys : _ t -> int sequence

val values : 'a t -> 'a sequence

val add_gen : 'a t -> (int * 'a) gen -> 'a t
(** @since 0.13 *)

val of_gen : (int * 'a) gen -> 'a t
(** @since 0.13 *)

val to_gen : 'a t -> (int * 'a) gen
(** @since 0.13 *)

val add_klist : 'a t -> (int * 'a) klist -> 'a t
(** @since 0.13 *)

val of_klist : (int * 'a) klist -> 'a t
(** @since 0.13 *)

val to_klist : 'a t -> (int * 'a) klist
(** @since 0.13 *)

type 'a tree = unit -> [`Nil | `Node of 'a * 'a tree list]

val as_tree : 'a t -> [`Node of int * int | `Leaf of int * 'a ] tree

(** {2 IO} *)

type 'a printer = Format.formatter -> 'a -> unit

val print : 'a printer -> 'a t printer
(** @since 0.13 *)

(** Helpers *)

(**/**)

module Bit : sig
  type t = private int
  val min_int : t
  val highest : int -> t
end
val check_invariants : _ t -> bool

(**/**)
