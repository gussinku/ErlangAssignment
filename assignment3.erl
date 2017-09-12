-module(assignment3).

-export([adj_duplicates/1, split/2,
	 normalize/1, normalize2/1,
         last/1, find/2, sort/1,
         map/2, map2/2, filter/2, filter2/2,
         digitize/1, is_happy/1, all_happy/2,
         expr_eval/1, expr_print/1,
         dict_new/0, dict_get/2, dict_put/3,
         dict_wellformed/1, dict_map_values/2,
         tree_wellformed/1, tree_make_bfs/1, tree_bind/2,
         tree_flatten/1, tree_dfs/1, tree_sorted/1, tree_find/2
        ]).


% 2. Basic functions, lists and tuples

adj_duplicates(_L) -> not_implemented.

split(_, _) -> not_implemented.

normalize(_L) -> not_implemented.

normalize2(_L) -> not_implemented.

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


