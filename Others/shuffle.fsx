open System

let rec rmerge l r =
    match (l, r) with
    | ([], r) -> r
    | (l, []) -> l
    | (lt :: ls, rt :: rs) ->
        if Random().Next(0, 2) = 0 then
            lt :: rmerge ls (rt :: rs)
        else
            rt :: rmerge (lt :: ls) rs

let rec shuffle l =
    match l with
    | [] -> []
    | [ x ] -> [ x ]
    | l ->
        let (ls, rs) = List.splitAt ((List.length l) / 2) l
        rmerge (shuffle ls) (shuffle rs)

printfn "%A" (shuffle [ 1; 2; 3; 4; 5; 6 ])

let rec search (xs: int []) v l r =
    if l = r then
        if xs.[l] = v then v else -1
    else if v > xs.[(l + r) / 2] then
        search xs v ((l + r) / 2 + 1) r
    else
        search xs v l ((l + r) / 2)
