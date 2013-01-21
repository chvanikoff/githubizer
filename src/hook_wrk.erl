-module(hook_wrk).
-author('chvanikoff <chvanikoff@gmail.com>').

%% API
-export([run/1]).

%% ===================================================================
%% API functions
%% ===================================================================

run(Post) ->
	print_with_datetime("~nHook worker called~n"),
	{ok, [Docroot, User, Repo]}
		= cfgsrv:get("server.docroot", "github.username", "github.repository"),
	[{<<"payload">>, JSON}] = Post,
	_Decoded = mochijson2:decode(JSON), %% Maybe I will do something nice with it... Later
	os:cmd("mkdir -p " ++ Docroot),
	case os:cmd("ls " ++ Docroot) of
		[] ->
			os:cmd("git clone git@github.com:" ++ User ++ "/" ++ Repo ++ ".git " ++ Docroot);
		_ ->
			ok
	end,
	os:cmd("cd " ++ Docroot ++ " && git pull"),
	print_with_datetime("New revision pulled~n").

%% ===================================================================
%% Internal functions
%% ===================================================================

print_with_datetime(Str) ->
	io:format("[~p.~p.~p ~p:~p:~p.~p] " ++ Str ++ "~n", datetime()).

datetime() ->
	[{{Y, M, D}, {H, I, S}}, {_ ,_ ,MT}] = [calendar:now_to_local_time(now()), now()],
	[D, M, Y, H, I, S, MT].