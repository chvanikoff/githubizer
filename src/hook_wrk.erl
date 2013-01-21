-module(hook_wrk).
-author('chvanikoff <chvanikoff@gmail.com>').

%% API
-export([run/1]).

%% ===================================================================
%% API functions
%% ===================================================================

run(Post) ->
	print_with_datetime("Hook worker called"),
	[{<<"payload">>, JSON}] = Post,
	_Decoded = mochijson2:decode(JSON),
	os:cmd("cd ../traviania && git pull"),
	print_with_datetime("New revision pulled").

%% ===================================================================
%% Internal functions
%% ===================================================================

print_with_datetime(Str) ->
	io:format("[~p.~p.~p ~p:~p:~p.~p] " ++ Str ++ "~n", datetime()).

datetime() ->
	[{{Y, M, D}, {H, I, S}}, {_ ,_ ,MT}] = [calendar:now_to_local_time(now()), now()],
	[D, M, Y, H, I, S, MT].