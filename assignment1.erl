%% @doc This is the first assignment that introduces students in Erlang programming with examples in pattern matching,function defination,data types, maths operation and logic operators etc.
%% XHTML markup </em>.
%%
%% @author Kundananji.Sinkala    <gussinku@student.gu.se> 
%% @author Marcus.Wrang <gusmarwr@student.gu.se>
%% @version 3.0
%% @ Group 8 Assignment1 DIT027
%% @copyright @2017 Marcus & Kundananji
%@ All Test cases passed.
%% display as "YYYY-MM-DD".
%%................................................................

-module(assignment1).
-export([even_odd/1,f2c/1,c2f/1,convert/1,even_odd2/1,price/1,stretch_if_square/1,
            convert2/1,measure/3,any_2_equal/3,range_overlap/2,get_amp/1,rect_overlap/2]).

%% 2. Basic functions
%this take a value Y and determins if value is old or even
even_odd(Y) when Y rem 2 == 0 -> even;
even_odd(_) -> odd.

  %tThis formula converts fahrenheit  to celsius and celsius to fahrenheit   
  f2c(F) -> 5/9 * (F - 32).
  c2f(C)  -> 32 + (C * 9/5).

convert({f,F}) -> {c,f2c(F)};
convert({c,C}) -> {f,c2f(C)}.  

% 3. Refactoring
even_odd2(X)  ->
        if X rem 2 == 0 -> even;
          true -> odd end. 

price({A,N}) when A == apple -> 11 * N;
price({A,N}) when A == orange -> 15 * N + 2;
price({A,B,N}) when A == banana andalso B == costarica -> 8 * N;
price({A,B,N}) when A == banana andalso B == equador -> 9 * N + 2.


% Do not modify this function
rect_to_square({rect, A, A}) -> {square, A};
rect_to_square({rect, _, _}) -> not_square.

 stretch_if_square(Z) ->
     case rect_to_square(Z) of 
        
        {square, A} -> {rect , A , A * 2};
        not_square -> Z        
     end.  

%The function returns temperature in either Celsius or Fahrenheit usibg case expresssion.
convert2(Con)->
    case Con of 
    {f,F} -> {c,f2c(F)};  
    {c,C} -> {f,c2f(C)}

        end.

% 4. More functions
range_overlap({A1,A2}, {B1,B2}) when A2 > B1 andalso A1 < B2
             -> {overlap, {max(A1, B1), min(A2, B2)}};
      range_overlap(_, _) -> no_overlap.

%optional
%The function should return a pair of the atom overlap and the rectangle
rect_overlap({rect, {X11, Y11}, {X12, Y12}},{rect, {X21, Y21}, {X22, Y22}}) ->
rect_fnx(range_overlap({X11, X12}, {X21, X22}),
      range_overlap({Y11, Y12}, {Y21, Y22})).

rect_fnx({overlap, {A1, A2}}, {overlap, {B1, B2}}) ->
{overlap, {rect, {A1, B1}, {A2, B2}}};
rect_fnx(_, _) -> no_overlap.





%Takes a description of an amplification circuit and returns its amplification factor
get_amp({amplifier,PreAmp,Factor,_Noise}) ->
amp_fun(PreAmp) + Factor.
amp_fun(no_preamp)  -> 0;
amp_fun({preamp, Factor}) -> Factor.

% 5. Non-linear patterns
%check if the values of two arguments are the same
measure(X ,N ,N) -> X + 1;
measure(X,N ,M) -> X + N - M.

%Takes 3 arguments and returns true if any two of them are equal
any_2_equal(X , X ,_) -> true;
any_2_equal(X, _ , X ) -> true;
any_2_equal( _ , X , X) ->true;
any_2_equal( _ , _ , _) -> false.