-module(assignment4_store).
-export([start/0, init/0, stop/0, store/2, fetch/1, flush/0
        ]).
start() -> 
        case whereis(sts) of
          undefined ->
             Pid = spawn(fun() -> init() end),
             register(sts, Pid),
             {ok, Pid};
          Pid  ->
             {ok,Pid}
     end.
   

 init() -> io:format("Starting... ~n"),
       loop([]).

   
      loop(Dict) ->
          io:format("dict is ... ~n"),
          receive
                  {store, K, V, Pid} ->
                    case proplists:is_defined(K, Dict) of
                      false     -> Dict2 = [{K, V}| Dict], Pid ! {value, V};
                      true       -> Dict2 = Dict, Pid ! {ok,no_value}
                    end,
                    loop(Dict2);
                  {fetch, K, Pid} ->
                    case proplists:is_defined(K, Dict) of
                      true     -> [{_K2, V}] = proplists:lookup_all(K, Dict),Pid ! {value, V};
                      false       -> Pid ! {error, not_found}
                    end,
                    loop(Dict);

                  {stop, Pid} ->  
                    Pid ! done;

                  {flush,Pid} ->
                  Pid ! ok,
                  loop([])
                end.
stop() ->
  sts ! {stop, self()},
  receive
    done -> ok
after 500 -> process_might_be_stopped
end.
store(K, V) ->
  sts ! {store, K, V, self()},
receive
  {error, not_found} -> {error, not_found};
  {value, V} -> {value, V}
end.
fetch(K) ->
  sts ! {fetch, K, self()},
  receive
    {value, V} -> {value, V};
    {error, not_found} -> {error, not_found}
  end.

  flush() ->
      receive
          M -> 
              io:format("Shell got ~p~n",[M]),
              flush()
      after 0 ->
          ok
      end.
