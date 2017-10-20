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
 pmap(Fun, Data) ->
    Self = self(),
    Pids = [spawn(fun() -> 
        Res = case catch {ok, Fun(N)} of
                {ok, R} -> R;
                  R -> R
            end,
        Self ! {self(), Res}end) || N <- Data],

    [ receive {Pid, N} -> N end || Pid <- Pids ].

%%
%% Problem 4
%%

% Write your answer here.

%f() read 6
%g() read 5
%test() read 3

%This sherlock holmes resoning is when the process is started , we know that before test() read 3 is printed there is a also a process add(P,3 ) 
% that occured and before the g() read 5 printed and 
% after g() read 3 there is another process that ocuured which was add 2 from g hence the g read 5 and after that we added 1 from f() read 6


