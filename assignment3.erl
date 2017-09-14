-module(assignment3).

-export([adj_duplicates/1,%split/2,%
	 normalize/1, normalize2/1,
         last/1, find/2,aux_sort/2,sort/1,
         map/2, map2/2, filter/2, filter2/2,
         digitize/1, is_happy/1, all_happy/2,
         expr_eval/1, expr_print/1,
         dict_new/0, dict_get/2, dict_put/3,
         dict_wellformed/1, dict_map_values/2,
         tree_wellformed/1, tree_make_bfs/1, tree_bind/2,
         tree_flatten/1, tree_dfs/1, tree_sorted/1, tree_find/2,max_norma/1
        ]).


% 2. Basic functions, lists and tuples
%Check two elelments of the list is the same,returns the head
adj_duplicates([]) -> [];
adj_duplicates([A,A|Tail]) -> [A|adj_duplicates([A|Tail])];
adj_duplicates([_Head|Tail]) -> adj_duplicates(Tail).


%split(0,L) -> {[],L};
%split(_,[]] -> {[],[]};
%split(N,X|Xs) -> 
  %{X,Y} = split(N -1,Xs),{[X|Y],Z}.



normalize(L) -> [ X / max_norma(L)|| X <- L].
max_norma(L) -> max_norma(L ,0). 
max_norma([],N) -> N;
max_norma([H|T],N) when H > N -> max_norma(T,H);
max_norma([H|T],N) when H =< N -> max_norma(T,N).

%This functions returns a new list from function 
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


sort(L) -> sort(L,[]).
sort([],S) -> S;
sort([H|T],S) -> sort(T, aux_sort(H , S)).  

aux_sort(X,[]) -> [X];
aux_sort(X,[H]) when X =< H -> [X|[H]];
aux_sort(X,[H|T]) -> [H|aux_sort(X, T)].
 

    


%
    map(F, [H|T]) -> [F(H)| map(F, T)];
    map(_F, []) -> [].
%List comprehension of a map function
 map2(F, L) -> [ F(X)  ||  X <- L ].

filter(_, _) -> not_implemented.

filter2(_, _) -> not_implemented.


% 3. Digitify a number 

digitize(_) -> not_implemented.


% 4. Happy numbers

is_happy(_) -> not_implemented.

all_happy(_, _) -> not_implemented.


% 5. Expressions

expr_eval(_) -> not_implemented.

expr_print(_) -> not_implemented.


% 6. Dictionary

dict_new() -> not_implemented.

dict_get(_, _) -> not_implemented.

dict_put(_, _, _) -> not_implemented.

dict_wellformed(_) -> not_implemented.

dict_map_values(_, _) -> not_implemented.


% 7. Trees

tree_wellformed(_) -> not_implemented.

tree_make_bfs(_) -> not_implemented.

tree_bind(_, _) -> not_implemented.

tree_flatten(_) -> not_implemented.

tree_dfs(_) -> not_implemented.

tree_sorted(_) -> not_implemented.

tree_find(_, _) -> not_implemented.


