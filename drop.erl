-module(drop).
-export([fall_velocity/1,take/2,bun/1,
nub/1,fall_velocity2/2,sum2/3,sum1/3,palin/1,sum4/1,sum5/1,palindrome/1,nocaps/1]).
-include_lib("eunit/include/eunit.hrl").
%%test cases,
take_1_test() -> ?assertEqual(palindrome("Madam I'm Adam.").

%encapsulating a function
fall_velocity({Planero,Distance}) -> fall_velocity(Planero,Distance).

fall_velocity(earth,Distance) when Distance >= 0 -> math:sqrt(2 * 9.8 *Distance);
fall_velocity(moon,Distance) when Distance >= 0 -> math:sqrt(2 * 1.6 *Distance);
fall_velocity(mars,Distance) when Distance >= 0 -> math:sqrt(2 * 3.71 *Distance).

% Case expression
fall_velocity2(Planero,Distance) when Distance >= 0 ->
    case Planero of
            earth -> math:sqrt(2 * 9.8 * Distance);
            moon -> math:sqrt(2 * 1.6 * Distance);
             mars -> math:sqrt(2 * 3.7 * Distance)
           
    end.
% Recursion
sum2(N,N,I) -> I + N;
sum2(N,M,I) -> sum2(N,M + 1, I + M).

sum1(N,N,I) -> I * N;
sum1(N,M,I) -> sum2(N,M +1, I * M).


%List direct recursion
 sum4 ([]) -> 0;
sum4([X |Xs]) -> X + sum4(Xs).
% sum with tail recursion
sum5(Xs) -> sum5(Xs,0).
sum5([],S) -> S;
sum5([X|Xs],S) -> sum5(Xs, X + S).

%maximum
%maximum([X]) -> _;
%maximum([X| Xs]) -> max( X, maximum(Xs)).

%
take(0,_Xs) -> [];
take(_N, []) -> [];
take(N,[X|Xs]) when  N > 0 -> [X|take(N -1,Xs)].

%nub [2,4,1,3,3,1]
nub([]) -> [];
nub ([X|Xs]) -> [X |nub(removeAll(X,Xs))].
removeAll(_,[]) ->[];
removeAll(X,[X|Xs])-> removeAll(X,Xs);
removeAll(X,[Y|Xs]) ->
    [Y| removeAll(X,Xs)].


bun ([]) -> [];
bun ([X|Xs]) ->
    case member(X,Xs) of 
        true ->
            bun(Xs);
        false ->
            [X|bun(Xs)]
    end.
member(_,[]) ->
    false;
member(X,[X|_Xs]) ->
    true;
member (X,[_Y|Xs]) ->
    member(X,Xs).

%Palindrome
% palindrome ("Madam I'm Adam") = true
palindrome(Xs) -> palin(nocaps(nopunct(Xs))).
nopunct([]) -> [];
nopunct([X|Xs]) -> 
    case lists:member(X,".,\;:\t\n '\"") of
        true ->
            nopunct(Xs);
        false ->
            [X | nopunct(Xs)]
end.

nocaps([]) -> [];
nocaps([X | Xs]) -> [nocap(X)|nocaps(Xs)].
nocap(X) ->
    case $A =< X andalso X =< $Z of 
        true ->
            X + 32;
        false ->
            X
end.
palin (Xs) -> Xs == reverse(Xs).
reverse(Xs) -> 
    shunt(Xs,[]).

shunt([],Ys) ->
    Ys;
shunt([X|Xs],Ys) ->
    shunt(Xs,[X|Ys]).



