-module(day1).
-export([start_parsing/1, test/1]).

two_num_equality([A, B]) -> 
	A == B.

recurse_numbers([_]) ->
	0;
recurse_numbers(Data) ->
	{Comparator, _} = lists:split(2, Data),
	{Reference, _} = lists:split(1, Comparator),
	case two_num_equality(Comparator) of
		true -> list_to_integer(Reference) + recurse_numbers(tl(Data));
		false -> 0 + recurse_numbers(tl(Data))
	end.

make_circular(List) ->
	[First | _] = List,
	List ++ [First].

test(List) ->
	recurse_numbers(make_circular(List)).

start_parsing(Filepath) ->
	case file:read_file(Filepath) of
		{ok, Data} -> recurse_numbers(make_circular(binary_to_list(Data)));
		_ -> {err}
	end.