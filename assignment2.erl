-module(assignment2).

-export([sum_interval/2, mul_interval/2, sum_sq_interval/2,
         sum_interval_t/2, mul_interval_t/2, sum_sq_interval_t/2,
         sum/1, mul/1, sum_sq/1,
         sum_t/1, mul_t/1, sum_sq_t/1,
         interval/2,
         sum_interval_l/2, mul_interval_l/2, sum_sq_interval_l/2,
         sum_sq_interval_l2/2,
         concat_rev/2, reverse/1,
	 expand_circles/2, print_circles/1, even_fruit/1,
         ferry_vehicles/2, ferry_vehicles2/2,
	 print_0_n/1, print_n_0/1, print_0_n_0/1,
	 print_sum_0_n/1
        ]).


% Statement of contribution:
%
%
%
%
%
%
%
%
%
%
%
%
%

% 2. Basic recursion

sum_interval(N, M) when N > M -> 0;
sum_interval(N, M)            ->
  N + sum_interval(N + 1, M).



mul_interval(N, M) when N > M -> 1;
mul_interval(N, M) -> N * mul_interval(N + 1 , M). 




sum_sq_interval(N, M) when N > M -> 0;
sum_sq_interval(N, M) ->
    N * N + sum_sq_interval(N + 1, M).




sum_interval_t(N, M) -> sum_interval_t(N, M, 0).
  sum_interval_t(N, M, Acc) when N > M -> Acc;
    sum_interval_t(N, M, Acc)            ->
      sum_interval_t(N + 1, M, Acc + N).

  mul_interval_t(N, M) -> mul_interval_t(N, M, 1).
    mul_interval_t(N, M, Acc) when N > M -> Acc;
      mul_interval_t(N, M, Acc)            ->
        mul_interval_t(N + 1, M, Acc + N * N).

  sum_sq_interval_t(N, M) -> sum_sq_interval_t(N, M, 0).
    sum_sq_interval_t(N, M, Acc) when N > M -> Acc;
      sum_sq_interval_t(N, M, Acc)            ->
        sum_sq_interval_t(N + 1, M, Acc + N * N).
    


% 3. Recursion on lists

sum([])     -> 0;
sum([X|Xs]) -> X + sum(Xs).


mul([])     -> 1;
mul([X|Xs]) -> X * mul(Xs).

sum_sq([])     -> 0;
sum_sq([X|Xs]) -> X * X + sum_sq(Xs).

sum_t(L) -> sum_t(L, 0).

sum_t([], Acc)     -> Acc;
sum_t([X|Xs], Acc) -> sum_t(Xs, Acc + X).

mul_t(_) -> not_implemented.

sum_sq_t(_) -> not_implemented.

interval(_, _) -> not_implemented.

sum_interval_l(_, _) -> not_implemented.

mul_interval_l(_, _) -> not_implemented.

sum_sq_interval_l(_, _) -> not_implemented.

sum_sq_interval_l2(_, _) -> not_implemented.

concat_rev(_, _) -> not_implemented.

reverse(_) -> not_implemented.

% 4. List comprehensions

expand_circles(M, L) -> [ {circle, D * M} || {circle, D} <- L ].

print_circles(_) -> not_implemented.

even_fruit(_) -> not_implemented.

ferry_vehicles(_, _) -> not_implemented.

ferry_vehicles2(_, _) -> not_implemented.


% 5. Recursion and side-effects

print_0_n(N, N) -> io:format("~p~n", [N]);
  print_0_n(N, I) ->
    io:format("~p~n", [I]),
      print_0_n(N, I+1).
print_0_n(N) -> print_0_n(N, 0).


print_n_0(N, N) ->io:format("~p~n" ,[N]);
  print_n_0(N, I) ->
      print_n_0(N, I + 1),
        io:format("~p~n" ,[I]).
 print_n_0(N) ->print_n_0(N,0).







%%print_n_0(_) -> not_implemented.

print_0_n_0(0) -> io:format("0~n");
print_0_n_0(N) ->
  io:format("~p~n", [N]),
  print_0_n_0(N-1).


print_sum_0_n(N, N, Acc) -> io:format("~p~n", [N]), Acc + N;
print_sum_0_n(N, I, Acc) ->
  io:format("~p~n", [I]),
  print_sum_0_n(N, I + 1, Acc + I ).

print_sum_0_n(N) -> print_sum_0_n(N, 0, 0).


