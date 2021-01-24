Inductive day : Type :=
    | mon
    | tue
    | wed
    | thu
    | fri
    | sat
    | sun.

Definition nextday (d: day) : day :=
    match d with
    | mon => tue
    | tue => wed
    | wed => thu
    | thu => fri
    | fri => sat
    | sat => sun
    | sun => mon
    end.

Compute (nextday fri).
Compute (nextday (nextday sun)).

Example testnext:
    (nextday (nextday sat)) = mon.

Proof. simpl. reflexivity. Qed.

Inductive bool: Type :=
    | true
    | false.

Definition negb (b: bool) : bool :=
    match b with
    | true => false
    | false => true
    end.

Definition andb (b1: bool) (b2: bool) : bool :=
    match b1 with
    | true => b2
    | false => false
    end.

Definition orb (b1: bool) (b2: bool) : bool :=
    match b1 with
    | true => true
    | false => b2
    end.

Definition  nandb (b1: bool) (b2: bool) : bool :=
    negb (andb b1 b2).


Example test1: (orb true false) = true.
Proof. simpl. reflexivity. Qed.

(* Example test2: (andb true false) = true.
Proof. simpl. reflexivity. Qed. *)

Notation "x && y" := (andb x y).
Notation "x || y" := (orb x y).

Compute (true && false).

Example test3: false || true || false = true.
Proof. simpl. reflexivity. Qed.

Example test4: nandb true true = false.
Proof. simpl. reflexivity. Qed.

Check true.
Check negb.

Inductive rgb: Type :=
    | red
    | green
    | blue.

Inductive color: Type :=
    | black
    | white
    | primary (p: rgb).

Definition monochrome (c: color) : bool :=
    match c with
    | black => true
    | white => true
    | primary q => false
    end.

Definition isred (c: color) : bool :=
    match c with
    | black => false
    | white => false
    | primary red => true
    | primary _ => false
    end.


Compute (monochrome (primary red)).
Compute (isred (primary red)).

Check primary.

Inductive bit: Type :=
    | B0
    | B1.

Inductive nybble: Type :=
    | bits (b0 b1 b2 b3 : bit).

Check (bits B1 B0 B1 B0).

Definition allzero (nb: nybble) : bool :=
    match nb with
    | (bits B0 B0 B0 B0) => true
    | _ => false
    end.

Compute (allzero (bits B1 B0 B1 B0)).
Compute (allzero (bits B0 B0 B0 B0)).
