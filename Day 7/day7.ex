defmodule Parser do
    @endsregex ~r/(.+)\s\((\d+)\)(\n|$)/
    @rootregex ~r/(.+)\s\((\d+)\)\s->\s(.+)/
    @allregex ~r/(.+)\s\((\d+)\)/

    defp flatIntoMap(aom) do
        aom
            |> Enum.flat_map(&(&1))
            |> Enum.into(%{})
    end

    defp parseEnds(string) do
        parsed = Regex.run(@endsregex, string)
        [_, name, weight, _] = parsed
        {nweight, _} = Integer.parse(weight)
        Map.put(%{}, name, %{weight: nweight})
    end
    
    defp parseRoots(string) do
        parsed = Regex.run(@rootregex, string)
        [_, name, weight, branches] = parsed
        {nweight, _} = Integer.parse(weight)
        sbranches = String.split(branches, ", ")
        Map.put(%{}, name, %{weight: nweight, branches: sbranches})
    end

    defp getName(string) do
        [_, name, _] = Regex.run(@allregex, string)
        name
    end
    
    defp getBranches(string) do
        parsed = Regex.run(@rootregex, string)
        [_, _, _, branches] = parsed
        String.split(branches, ", ")
    end
    
    defp sortOutput(string) do
        if Regex.match?(@endsregex, string) do
            string |> parseEnds
        else
            string |> parseRoots
        end
    end
    
    defp filterInputToRoot(string) do
        Regex.match?(@rootregex, string)
    end
    
    def getAllNames(data) do
        data
            |> String.split("\n")
            |> Enum.map(&getName/1)
    end
    
    def getAllBranches(data) do
        data
            |> String.split("\n")
            |> Enum.filter(&filterInputToRoot/1)
            |> Enum.map(&getBranches/1)
            |> List.flatten
    end
    
    def parseInput(data) do
        data
            |> String.split("\n")
            |> Enum.map(&sortOutput/1)
            |> flatIntoMap
    end
end

defmodule Tree do
    defp sumBranch(tree, root) do
        node = tree[root]
        %{weight: weight} = node
        if Map.has_key?(node, :branches) do
            %{branches: branches} = node
            branches
            weight + Enum.reduce(branches, 0, fn(x, acc) ->
                acc + sumBranch(tree, x)
            end)
        else
            weight 
        end
    end
    
    defp unevenBranch?(tree, node) do
        {_root, meta} = node
        if Map.has_key?(meta, :branches) do
            %{branches: branches} = meta
            reduced = branches
                |> Enum.map(&sumBranch(tree, &1))
                |> Enum.uniq
                |> length
            reduced > 1
        else
            false
        end
    end
    
    defp getSums(tree, inp) do
        {root, %{branches: branches}} = inp
        sums = branches |> Enum.map(fn x -> 
            {x, sumBranch(tree, x), tree[x][:weight]}
        end)
        {root, sums}
    end
    
    def traverseUneven(tree) do
        # search for uneven branches
        tree
            |> Enum.filter(&unevenBranch?(tree, &1))
            |> Enum.map(&getSums(tree, &1))
    end
end

defmodule AoC do
    def getInput do
        IO.read(:stdio, :all)
    end

    def part1(input) do
        Parser.getAllNames(input) -- Parser.getAllBranches(input)
    end
    
    def part2(input) do
        input
            |> Parser.parseInput
            |> Tree.traverseUneven
    end
end

input = AoC.getInput
input |> AoC.part1 |> IO.inspect
input |> AoC.part2 |> IO.inspect