-module(assignment4).

-export([task/1, dist_task/1,pmap/2,faulty_task/1]).



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

%This function given a list of numbers, spawn a process for each computation and collect all the computation results
dist_task(L) ->
        Parent = self(),
        Pids = [spawn(fun() ->
                   Parent ! {self(),task(X)}
                end) || X <- L],
                [receive {Pid,Res} -> Res end || Pid <- Pids].


 %catches errors and include them in the map as normal values to the user
pmap(F, L) ->
        await1(spawn_jobs1(F,L)). 
        spawn_jobs1(F, L) ->
           Parent = self(),
           [spawn(fun() ->
        Parent ! {self(), catch F(X)} end) || X <- L].
%monitors the pids and match them to specific ref
        await1(Pids) ->
        [receive {Pid,Res} -> Res end || Pid <- Pids].




%%
%% Problem 4
%%

% Write your answer here.

