(* original = | |
   q1 = |5|
   q2 = |5||6| *)
(* Utility functions *)
module U = struct
  let string_of_list f l = "[ " ^ List.fold_left (fun a b -> a ^ (f b) ^ "; ") "" l ^ "]"
  let print_header h = Printf.printf "%s" ("\n" ^ h ^ "\n")
end

(* Queue *)
let _ =
  U.print_header "Queue";
  let module IntAtom = struct
    type t = int
    let compare = Pervasives.compare
    (* User defined merges for atom values *)
    let resolve x y = '#'
    let merge3 ~ancestor x y = '#'

    (* Used for presentation purposes *)
    let to_string = string_of_int
  end in

  let module M = Queue_imp.Make(IntAtom) in

  let original = M.empty  in 
  let q1 =  original |> M.add 5 in 
  let q2 = original |> M.add 5 |> M.add 6  in 
  (* Edit seq generation demonstration *)
  let edit_seq_printer = U.string_of_list (M.edit_to_string IntAtom.to_string) in 
  (* edit seq generation with diff *)
  let p = M.op_diff original q1 in
  let q = M.op_diff original q2 in
    Printf.printf "p = diff original v1: %s\n" (edit_seq_printer p);
    Printf.printf "q = diff original v2: %s\n" (edit_seq_printer q);;



