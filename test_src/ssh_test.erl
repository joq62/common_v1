%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(ssh_test).  
     
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include_lib("eunit/include/eunit.hrl").


%% --------------------------------------------------------------------
-export([start/0]).

%% ====================================================================
%% External functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function:emulate loader
%% Description: requires pod+container module
%% Returns: non
%% --------------------------------------------------------------------
start()->
    ?debugMsg("Start ssh_test "),
   
%    ?debugMsg("Start connect  nodes "),
%    ?assertEqual(ok,connect_nodes()),
%    ?debugMsg("Stop connect nodes "),

    ?debugMsg("Start call nodes "),
    ?assertEqual(ok,call_nodes()),
    ?debugMsg("Stop call nodes "),
   
 
    ?debugMsg("Stop ssh_test "),
    ok.



 
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------
connect_nodes()->
    glurk=my_ssh:ssh_connect("192.168.0.130",60130,"ubuntu","festum01",2000),
    my_ssh:ssh_send("192.168.0.130",60130,"ubuntu","festum01","y",5000), 
    
    

    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------
call_nodes()->

    ["asus"]=my_ssh:ssh_send("192.168.0.100",60100,"pi","festum01","hostname  ",5000),   
    ["c3"]=my_ssh:ssh_send("192.168.0.130",60130,"ubuntu","festum01","hostname ",5000),   
    ["c1"]=my_ssh:ssh_send("192.168.0.201",60201,"joq62","festum01","hostname ",5000),
    ["c2"]=my_ssh:ssh_send("192.168.0.202",60202,"joq62","festum01","hostname ",5000),
   
    
    
    ok.
		
