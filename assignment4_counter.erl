-module(assignment4_counter).

-export([start/0, init/0, incr/1, fetch/1, reset/1, stop/1
        ]).
-export([loop/1]).


start() -> spawn(assignment4_counter,init,[]).

init() -> io:format("starting ...~n"),
        PID = self(),
          register(assignment4_counter,PID),
          loop({0,PID}).
      

loop({Count, S}) ->
   receive
        {incr,Pid} ->
                 Pid ! done, loop({Count+1, S});

        {fetch,Pid} ->
                   Pid ! Count,
                     loop({Count,S});
        
         {reset, Pid} ->
                Pid ! done,
                  loop({0, S});

                  {stop,Pid} -> 
                          Pid ! done

        end. 

incr(S) ->
         S ! {incr, self()},
         receive
                 done -> done
                after 500 -> process_might_be_stopped
                 end.

fetch(S) -> 
   S ! {fetch, self()},
       receive
           N -> N
        after 500 -> process_might_be_stopped
        end.

reset(S) ->  
    S ! {reset, self()},
   receive
        done -> ok
after 500 -> process_might_be_stopped
    end.

stop(S) ->    
S ! {stop, self()},
   receive
         done -> ok
        after 500 -> process_might_be_stopped

 end.
      