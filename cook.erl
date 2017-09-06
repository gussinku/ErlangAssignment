-module(cook).
-export([printList/1,printList1/2]).
%-import(list_to_integer()/0).

%tuples
%P = {adam,24,{july,29}}.
%[{fruit,X} || X <- [apple,orange,pera,banana]]

printList(P) ->
    io:format("This is a List comprehension ~p~n" ,list_to_integer(P)).


printList1(N, N) ->
    io:format("~p~n" ,[N]);
    printList1(N, I) ->
            io:format("~p~n" ,[I]),
            printList1(N, I + 1).

    printList1(N) ->
        printList1(N,0).

