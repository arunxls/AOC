#!/usr/bin/env escript
%% -*- erlang -*-

main(_) ->
    {ok, File} = file:open('day1.txt', [read]),
    Depths = readLines(File),
    Part1 = count_window(Depths, 1),
    Part2 = count_window(Depths, 3),
    io:format("~B ~B~n", [Part1, Part2]).

count_window(Depths, Window_Size) ->
    count_window(Depths, lists:nthtail(Window_Size, Depths), 0).

count_window(_, [], N) -> 
    N;

count_window([H1|T1], [H2|T2], N) ->
    Inc = if H1 < H2 -> 1; true -> 0 end,
    count_window(T1, T2, N + Inc).

readLines(File) ->
    lists:reverse(readLines(File, [])).

readLines(File, Acc) ->
    case file:read_line(File) of
        {ok, Data} -> readLines(File, [list_to_integer(string:trim(Data)) | Acc]);
        {error, _Reason} -> Acc;
        eof -> Acc
    end.