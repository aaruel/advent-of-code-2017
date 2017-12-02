fun numStringToList (line: string) = let
    val sep = String.tokens (fn c => c = #" ") line
    fun strToNum (s: string) = let
        val SOME num = Int.fromString s
    in
        num
    end
in
    map strToNum sep
end

fun readFileByLine (infile: string) = let
    val ins = TextIO.openIn infile
    fun loop ins = 
        case TextIO.inputLine ins of
            SOME line => numStringToList(line) :: loop ins
            | NONE    => []
in
    loop ins before TextIO.closeIn ins
end

fun highlow (l: int list, mm: bool) = let
    fun maxmin [] = raise Empty
        | maxmin [x] = x
        | maxmin (x :: xs) =
            let
                val y = maxmin xs
            in
                if ((x > y andalso mm) orelse (x < y andalso not mm)) then x else y
            end
in
    maxmin l
end

fun maxminDiff (l: int list) = let
    val max = highlow(l, true)
    val min = highlow(l, false)
in
    max - min
end

fun input (infile: string) = let
    val nlists = readFileByLine infile
    fun sumList [] = 0
        | sumList (x::xs) = x + (sumList xs)
in
    sumList(map maxminDiff nlists)
end