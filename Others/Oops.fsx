type 'a Tree =
    | Leaf
    | Node of 'a * 'a Tree * 'a Tree

let rec depth tree =
    match tree with
    | Leaf -> 0
    | Node (_, left, right) -> 1 + depth left + depth right

let sample = Node (2, Node (1, Leaf, Leaf), Node (3, Leaf, Leaf))

printfn "%O" sample
printfn "%d" (depth sample)
