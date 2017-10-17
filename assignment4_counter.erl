-module(assignment4_counter).

-export([start/0, init/0, incr/1, fetch/1, reset/1, stop/1
        ]).
-export([loop/1]).

%starting a server simulation
start() -> spawn(assignment4_counter,init,[]).

%register a process
init() -> io:format("starting ...~n"),
        PID = self(),
          register(assignment4_counter,PID),
          loop({0,PID}).
      
%main loop process for inr,fetch,reset and stop
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

%increment the process for every excution
incr(S) ->
         S ! {incr, self()},
         receive
                 done -> done
                 end.

%fetches process pid
fetch(S) -> 
   S ! {fetch, self()},
       receive
           N -> N
        end.

%resets the proesss with repective pid
reset(S) ->  
    S ! {reset, self()},
   receive
        done -> ok
    end.

%stops server process 
stop(S) ->    
S ! {stop, self()},
   receive
         done -> ok
 end.
      