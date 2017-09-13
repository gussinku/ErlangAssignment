-module(assignment3).

-export([adj_duplicates/1, %split/2,%
	 normalize/1, normalize2/1,
         last/1, find/2, sort/1,
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


%split(0,[]) -> [];
%split( N ,List) when N > length(List) -> [List];
%split(N, List) ->  { X  | X <- [N,List]},
%[Head | split( X | Tail )].



normalize(L) -> [ X / max_norma(L)|| X <- L].
max_norma(L) -> max_norma(L ,0). 
max_norma([],N) -> N;
max_norma([H|T],N) when H > N -> max_norma(T,H);
max_norma([H|T],N) when H =< N -> max_norma(T,N).

%This functions returns a new list from function 
normalize2(L) -> lists:map(fun (X) ->  X / max_norma(L) end, L).
 


last(Xs) ->
  if length(Xs) == 1 -> hd(Xs);
     true            -> last(tl(Xs))
  end.

find(_, _) -> not_implemented.

sort(_) -> not_implemented.

map(_, _) -> not_implemented.

map2(_, _) -> not_implemented.

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


