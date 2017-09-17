%% @author.Kundananji Sinkala <gussinku@student.gu.se>
%% @author. Markus Wrang <gusmarwr@student.gu.se>
%% @copyright 2017-08-16
%% Assignment3
%% All students put in 100% and we worked in pair programming to solve the task

-module(assignment3).

-export([adj_duplicates/1,split/2,
	 normalize/1, normalize2/1,
         last/1, find/2,aux_sort/2,sort/1,
         map/2, map2/2, filter/2, filter2/2,
         digitize/1, is_happy/1, all_happy/2,
         expr_eval/1, expr_print/1,
         dict_new/0, dict_get/2, %dict_put/3,
         %dict_wellformed/1, dict_map_values/2,
         %tree_wellformed/1, tree_make_bfs/1, tree_bind/2,
         %tree_flatten/1, tree_dfs/1, tree_sorted/1,reverse/1, tree_find/2,
         max_norma/1
        ]).


% 2. Basic functions, lists and tuples
%Check two elelments of the list is the same,returns the head
adj_duplicates([]) -> [];
adj_duplicates([A,A|Tail]) -> [A|adj_duplicates([A|Tail])];
adj_duplicates([_Head|Tail]) -> adj_duplicates(Tail).



%Function that splits a list and returns a new list based on N factor
split(N, L) ->  split(N, L, []).

split(N, L, Acc) when N < 0 -> {L, Acc};
split(_N, [], Acc) -> {reverse(Acc), []};
split(0, T, Acc) -> {reverse(Acc), T};
split(N, [H|T], Acc) when N > 0 -> split(N-1, T, [H|Acc]).
%Tail recursive function of reverse of a list .
reverse(L) -> reverse(L,[]).
reverse([],R) -> R;
reverse([H|T],R) -> reverse(T,[H|R]).



% Recursive implementation of normalisse function and return a new list .  
normalize(L) -> [ X / max_norma(L)|| X <- L].
max_norma(L) -> max_norma(L ,0). 
max_norma([],N) -> N;
max_norma([H|T],N) when H > N -> max_norma(T,H);
max_norma([H|T],N) when H =< N -> max_norma(T,N).

%This functions returns a new list from function using BIF  list module of Map in erlang
normalize2(L) -> lists:map(fun (X) ->  X / max_norma(L) end, L).
 

%Takes a list as argument and returns its last element
  last([])-> throw (crash);
  last([H|[]])-> H ;
  last([_|T])-> last(T) .

%Apply function thats take in the module, function and arguments abd returns true if any atoms are the same
find(Predicate, [H|T]) ->
  case Predicate(H) of
   true -> {found, H};
   false -> find(Predicate, T)
end;
find(_Predicate , []) -> not_found.  

%sort a list of elements by taking them one at a time and insert them into an already sorted list
sort(L) -> sort(L,[]).
sort([],S) -> S;
sort([H|T],S) -> sort(T, aux_sort(H , S)).  

aux_sort(X,[]) -> [X];
aux_sort(X,Z=[H|_]) when X =< H -> [X|Z];
aux_sort(X,[H|T]) -> [H|aux_sort(X, T)].
 

    


%Mapping elements to the  list
    map(F, [H|T]) -> [F(H)| map(F, T)];
    map(_F, []) -> [].
%List comprehension of a map function
 map2(F, L) -> [ F(X)  ||  X <- L ].

%using recursion The function takes a list of numbers and returns only those that are fullfill the condition statements.
 filter(F, [H|T]) ->
  case F(H) of
      true  -> [H|filter(F, T)];
      false -> filter(F, T)
  end;
filter(_F, []) -> [].

%using list comprehension. P is a predicate which means a function takes a value and returns boolean value
% instead of X== P, write P(X) == true.
filter2(F, L) -> [ X || X <- L, F(X)] .


% 3. Digitify a number 
%Takes a value and returns a list of numbers.
digitize(0) -> 1/0;
digitize(N) -> reverse(aux_digit(N)).
   
aux_digit(N) when N >= 0 -> 
        case N of  
            0 -> [];                                    
            _ -> [N rem 10 | aux_digit(N div 10)]
        end.



% 4. Happy numbers
%puts a digitise number and calculates it same and then compares the value with true or false if 1 or 4.
is_happy(1) -> true;
is_happy(4) -> false;
is_happy(N) -> D = digitize(N),is_happy(calculate(D,0)).
calculate([], Total)-> Total;
calculate([H | T], Total) -> calculate(T, Total + (H * H)).


%Uses the already implemeneted interval ,is_happy function and returns predate true or false of numbers between A and B
all_happy(N1, N2) -> [X || X <- interval(N1,N2), is_happy(X)].
interval(A, B) ->  interval(A, B, []).
interval(A,B, L) when A > B -> L;
interval(A,B,L) -> interval(A, B-1, [B|L]).

% 5. Expressions
%Simply expressions of functions
expr_eval({num, N}) -> N;
expr_eval({mul, N1, N2}) -> expr_eval(N1) * expr_eval(N2);
expr_eval({plus, N1, N2}) -> expr_eval(N1) + expr_eval(N2);
expr_eval({minus, N1, N2}) -> expr_eval(N1) - expr_eval(N2).

%Simply expressions of functions
expr_print({num, 0}) -> [$0 + 0];
expr_print({num, N}) -> [$0 + X|| X <- digitize(N)];
expr_print({mul, N1, N2}) -> lists:append("(", lists:append(expr_print(N1), lists:append("*",lists:append(expr_print(N2), ")"))));
expr_print({plus, N1, N2}) -> lists:append("(", lists:append(expr_print(N1), lists:append("+",lists:append(expr_print(N2), ")"))));
expr_print({minus, N1, N2}) -> lists:append("(", lists:append(expr_print(N1), lists:append("-",lists:append(expr_print(N2), ")")))).

% 6. Dictionary

%dict_new() -> dict:new([]).

%dict_get(D, K) when map2(_,K) -> dict:find(D, K).

%dict_put(F,C,V) -> dict:filter(F,C).


%returns an empty dict
dict_new() ->  {dict, []}.

%checks if there is a value corresponding to the specified key in the dictionary, returns {ok, val}
dict_get({dict, []}, _Key) -> not_found;
dict_get({dict,[{K1, V1}|_T]}, Key) when K1 == Key -> {found, V1};
dict_get({dict,[{_K1, _V1}|T]}, Key) -> dict_get({dict, T}, Key).

% Returns new dictionary with either mapped or not mapped key and value.
%dict_put(Dict, Key, V) -> dict_put(Dict, Key, V, []).
%dict_put({dict,[]}, Key, V, Extra) -> {{dict, lists:append(Extra, {Key, V})}, fresh};
%dict_put({dict,[{K1, V1}|T]}, Key, V, Extra) when K1 == Key ->  {{dict,[Extra,{K1, V}|T]},{previous, V1}};
%dict_put({dict,[H|T]}, Key, V, Extra) -> dict_put({dict, T}, Key, V, lists:append(Extra, [H])).


%dict_wellformed(_) -> not_implemented.

%dict_map_values(_, _) -> not_implemented.


% 7. Trees

%&%%tree_flatten(_) -> not_implemented.

%%%tree_find(_, _) -> not_implemented.


