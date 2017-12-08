defmodule Parser do
    @instruction ~r/^([^\s]+)\s([^\s]+)\s(-?[^\s]+)\sif\s([^\s]+)\s([^\s]+)\s(-?[^\s]+)/
    defp match(string) do
        [_, target, op, amt, cmp1, boolop, cmp2] = Regex.run(@instruction, string)
        {target, op, amt, cmp1, boolop, cmp2}
    end
    
    def run(input) do
        split = String.split(input, "\n")
        Enum.map(split, &match/1)
    end
end

defmodule Program do
    defp boolop(sign, cmp1, cmp2) do
        {n2, _} = Integer.parse(cmp2)
        %{
            "<" => fn(c1, c2) -> c1 < c2 end,
            ">" => fn(c1, c2) -> c1 > c2 end,
            "<=" => fn(c1, c2) -> c1 <= c2 end,
            ">=" => fn(c1, c2) -> c1 >= c2 end,
            "!=" => fn(c1, c2) -> c1 != c2 end,
            "==" => fn(c1, c2) -> c1 == c2 end
        }[sign].(cmp1, n2)
    end
    
    defp op(oper, cmp1, cmp2) do
        {n2, _} = Integer.parse(cmp2)
        %{
            "inc" => fn(c1, c2) -> c1 + c2 end,
            "dec" => fn(c1, c2) -> c1 - c2 end
        }[oper].(cmp1, n2)
    end
    
    defp checkreg(regs, reg) do
        if Map.has_key?(regs, reg) do
            regs
        else
            Map.put(regs, reg, 0)
        end
    end
    
    defp getHighest(regs) do
        Enum.reduce(regs, regs["highest"], fn({_key, value}, acc) ->
            if value > acc do
                value
            else
                acc
            end
        end)
    end
    
    defp exec(tup, acc) do
        {target, kop, amt, cmp1, kboolop, cmp2} = tup
        hold = acc 
            |> checkreg(target)
            |> checkreg(cmp1)
        dereftarget = hold[target]
        derefcmp1 = hold[cmp1]
        if boolop(kboolop, derefcmp1, cmp2) do
            pre = Map.put(hold, target, op(kop, dereftarget, amt))
            Map.put(pre, "highest", getHighest(pre))
        else
            hold
        end
    end
    
    def run(instructions) do
        Enum.reduce(instructions, %{"highest" => 0}, &exec/2)
    end
end

defmodule Day8 do
    def getInput do
        IO.read(:stdio, :all)
    end

    def parts(input) do
        Parser.run(input)
            |> Program.run
    end
end

input = Day8.getInput
input |> Day8.parts |> IO.inspect