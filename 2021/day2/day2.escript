#!/usr/bin/env escript
%% -*- erlang -*-

main(_) ->
    {ok, File} = file:open('day2.txt', [read]),
    Actions = readLines(File),
    Position1 = get_position(Actions),
    erlang:display(lists:nth(1, Position1) * lists:nth(2, Position1)),
    Position2 = get_position_with_aim(Actions),
    erlang:display(lists:nth(1, Position2)* lists:nth(2, Position2)).

get_position_with_aim(Actions) ->
    get_position_with_aim(Actions, [0,0,0]).

get_position_with_aim([], Coordinates) -> Coordinates;

get_position_with_aim([[Dir, Dist] | T], [X, Y, Aim]) ->
    case Dir of
        forward -> 
            X_modified = X + Dist,
            Y_modified = Y + Aim * Dist,
            Aim_modified = Aim;
        down ->
            Aim_modified = Aim + Dist,
            X_modified = X,
            Y_modified = Y;
        up ->
            Aim_modified = Aim - Dist,
            X_modified = X,
            Y_modified = Y
        end,
        get_position_with_aim(T, [X_modified, Y_modified, Aim_modified]).


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
    lists:reverse(readLines(File, [])).

readLines(File, Acc) ->
    case file:read_line(File) of
        {ok, Data} -> 
                Sanitized_data = string:split(string:trim(Data), " "),
                Transformed_data = [list_to_atom(lists:nth(1, Sanitized_data)), list_to_integer(lists:nth(2, Sanitized_data))],
                readLines(File, [Transformed_data|Acc]);
        eof -> Acc;
        {error, _Reason} -> Acc
    end.