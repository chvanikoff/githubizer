-module(githubizer_app).
-author('chvanikoff <chvanikoff@gmail.com>').

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	Sup = githubizer_sup:start_link(),
	{ok, [Port, Url, Nba]} = cfgsrv:get_multiple(["http_server.port", "http_server.url", "http_server.nba"]),
	Dispatch = [
		{'_', [
			{Url, hook_handler, []},
			{'_', default_handler, []}
		]}
	],
	{ok, _} = cowboy:start_http(http, Nba,
		[{port, Port}],
		[{env, [{dispatch, Dispatch}]}]
	),
    Sup.

stop(_State) ->
    ok.
