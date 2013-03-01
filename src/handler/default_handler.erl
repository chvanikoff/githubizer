-module(default_handler).
-author('chvanikoff <chvanikoff@gmail.com>').

-behaviour(cowboy_http_handler).

%% Cowboy_http_handler callbacks
-export([
	init/3,
	handle/2,
	terminate/3
]).

%% ===================================================================
%% Cowboy_http_handler callbacks
%% ===================================================================

init(_Transport, Req, []) ->
	{ok, Req, undefined}.

handle(Req, State) ->
	HTML = <<"<h1>404 Page Not Found</h1>">>,
	{ok, Req2} = cowboy_req:reply(404, [], HTML, Req),
	{ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
	ok.