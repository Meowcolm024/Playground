type Dispatch =
    | Raw of string
    | IOFunc of (string -> unit)
    | IO of unit

let naivePerson fname lname = (fname, lname)

let person fn ln =
    let mutable fname = fn
    let mutable lname = ln

    fun msg ->
        match msg with
        | "firstName" -> Raw fname
        | "lastName" -> Raw lname
        | "setFname" -> IOFunc(fun n -> (fname <- n))
        | "show" -> Raw(fname + " " + lname)

let firstName p = p "firstName"
let lastName p = p "lastName"

let setFname p n =
    match p "setFname" with
    | IOFunc f -> f n

let show p = p "show"

let personNew p a =
    let baseclass = p
    let mutable age = a

    fun msg ->
        match msg with
        | "age" -> Raw(string age)
        | "grow" -> (age <- age + 1) |> fun _ -> IO()
        | "show" ->
            match baseclass "show" with
            | Raw sh -> Raw(sh + " " + string age)
        | _ -> baseclass msg

let age p = p "age"
let grow p = p "grow"

let personNew2 fn ln a = personNew (person fn ln) a

// instances
let alice = naivePerson "kat" "alice"
let jack = person "mat" "jack"
let oldjack = personNew jack 60
let ben = personNew2 "han" "ben" 10

// class

type Personc(fn: string, ln: string) =
    let mutable fname = fn
    let mutable lname = ln

    member this.FirstName = fname
    member this.LastName = lname
    member this.Show = fname + " " + lname
    member this.SetFname n = fname <- n

type PersoncN(fn: string, ln: string, a: int) =
    inherit Personc(fn, ln)
    let mutable age = a

    member this.Age = age
    member this.Grow = age <- age + 1
    member this.Show = "<something>"
