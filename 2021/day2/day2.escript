#!/usr/bin/env escript
%% -*- erlang -*-

main(_) ->
    {ok, File} = file:open('day2.txt', [read]),
    Actions = readLines(File),
    Position = get_position(Actions),
    erlang:display(lists:nth(1, Position) * lists:nth(2, Position)).

get_position(Actions) ->
    get_position(Actions, [0,0]).

get_position([], Coordinates) ->
    Coordinates;

get_position([[Dir, Dist]|T], Coordinates) ->
    case Dir of
        forward -> get_position(T, [lists:nth(1, Coordinates) + Dist, lists:nth(2, Coordinates)]);
        down -> get_position(T, [lists:nth(1, Coordinates), lists:nth(2, Coordinates) + Dist]);
        up -> get_position(T, [lists:nth(1, Coordinates), lists:nth(2, Coordinates) - Dist])
    end.

readLines(File) ->
    readLines(File, []).

readLines(File, Acc) ->
    case file:read_line(File) of
        {ok, Data} -> 
                Sanitized_data = string:split(string:trim(Data), " "),
                Transformed_data = [list_to_atom(lists:nth(1, Sanitized_data)), list_to_integer(lists:nth(2, Sanitized_data))],
                readLines(File, [Transformed_data|Acc]);
        eof -> Acc;
        {error, _Reason} -> Acc
    end.