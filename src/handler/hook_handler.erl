-module(hook_handler).
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
	{ok, Post, Req2} = cowboy_req:body_qs(Req),
	spawn(hook_wrk, run, [Post]),
	HTML = <<"<h1>404 Page Not Found</h1>">>,
	{ok, Req3} = cowboy_req:reply(404, [], HTML, Req2),
	{ok, Req3, State}.

terminate(_Reason, _Req, _State) ->
	ok.