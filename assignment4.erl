-module(assignment4).

-export([task/1, dist_task/1, pmap/2, faulty_task/1
        ]).


%%
%% Process handling
%%

%% Do not change the following two functions!
task(N) when N < 0; N > 100 ->
    exit(parameter_out_of_range);
task(N) ->
    timer:sleep(N * 2),
    256 + 17 *((N rem 13) + 3).

faulty_task(N) when N < 0; N > 100 ->
    exit(parameter_out_of_range);
faulty_task(N) ->
    timer:sleep(N * 2),
    {_,_,X} = now(),
    case X rem 10 == 0 of
        false ->
            256 + 17 *((N rem 13) + 3);
        true  ->
            throw(unexpected_error)
    end.
%% End of no-change area

dist_task(_) ->
  not_implemented.

pmap(_, _) ->
  not_implemented.


%%
%% Problem 4
%%

% Write your answer here.

