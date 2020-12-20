%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(misc_cmn).  
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
 -include_lib("eunit/include/eunit.hrl").
%%---------------------------------------------------------------------
%% Records for test
%%

%% --------------------------------------------------------------------
-compile(export_all).


%% ====================================================================
%% External functions
%% ====================================================================


create_worker(User,PassWd,Ip,Port,HostId,VmId,Cookie,VmDir,AppId,Vsn,StartFun,GitPath)->
    {ok,Vm}=create_vm(User,PassWd,Ip,Port,HostId,VmId,Cookie),
    create_service(Vm,VmDir,AppId,Vsn,StartFun,GitPath),
    {ok,Vm}.



create_service(Vm,VmDir,AppId,Vsn,StartFun,GitPath)->

  %  ?assertEqual("1.0.0",Vsn),
    AppDir=string:concat(AppId,vsn_to_string(Vsn)),
    GitDest=filename:join(VmDir,AppDir),
    CodePath=filename:join([VmDir,AppDir,"ebin"]),
    AppModule=list_to_atom(AppId),

    %Test
  %  ?assertEqual("dbase_application100",AppDir),
  %  ?assertEqual("databases/dbase_application100", GitDest),
  %  ?assertEqual("databases/dbase_application100/ebin",CodePath),
  %  ?assertEqual(dbase_application,AppModule),

    true=vm_started(Vm),
    rpc:call(Vm,file,del_dir_r,[GitDest],3000),
    rpc:call(Vm,os,cmd,["git clone "++GitPath++" "++GitDest],10*1000),
    true=rpc:call(Vm,code,add_patha,[CodePath],3000),
    ?assertEqual(ok,rpc:call(Vm,AppModule,StartFun,[],3000)),
    {pong,_,AppModule}=rpc:call(Vm,AppModule,ping,[],3000),
    ok.

%%--------------------------------------------------------------------
%%   vm related functionality
%%--------------------------------------------------------------------

create_vm(User,PassWd,Ip,Port,HostId,VmId,Cookie,VmDir,AppId,Vsn,StartFun,GitPath)->
    {ok,Vm}=create_vm(User,PassWd,Ip,Port,HostId,VmId,Cookie),
    create_service(Vm,VmDir,AppId,Vsn,StartFun,GitPath).



create_vm(User,PassWd,Ip,Port,HostId,VmId,Cookie)->
    Vm=list_to_atom(VmId++"@"++HostId),
    true=stop_vm(Vm),  
    Reply=case my_ssh:ssh_send(Ip,Port,User,PassWd,"erl -sname "++VmId++" -setcookie "++Cookie++" -detached",5000) of
	      ok->
		  case vm_started(Vm) of
		      false->
			  {error,[ecreate_vm,Vm]};
		      true->
			  {ok,Vm}
		  end;
	      Err->
		  {error,[ecreate_vm,Err]}
	  end,
    Reply.

% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------


vsn_to_string(Vsn)->
    VsnList=string:lexemes(Vsn,"."),
    transform_vsn(lists:reverse(VsnList),"").

transform_vsn([],Str)->
    Str;
transform_vsn([S|T],Acc)->
     transform_vsn(T,string:concat(S,Acc)).

% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------

vm_started(Vm)->
    check_started(50,Vm,100,false).
    
check_started(_N,_Vm,_SleepTime,ok)->
    ok;
check_started(0,_Vm,_SleepTime,Result)->
    Result;
check_started(N,Vm,SleepTime,_Result)->
    NewResult=case net_adm:ping(Vm) of
		  pong->
		     true;
		  _Err->
		      timer:sleep(SleepTime),
		      false
	      end,
    check_started(N-1,Vm,SleepTime,NewResult).

% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
stop_vm(HostId,VmId)->
    Vm=list_to_atom(VmId++"@"++HostId),
    stop_vm(Vm).

stop_vm(Vm)->
    rpc:cast(Vm,init,stop,[]),
    vm_stopped(Vm).

vm_stopped(Vm)->
    check_stopped(50,Vm,100,false).
    
check_stopped(_N,_Vm,_SleepTime,ok)->
    ok;
check_stopped(0,_Vm,_SleepTime,Result)->
    Result;
check_stopped(N,Vm,SleepTime,_Result)->
    NewResult=case net_adm:ping(Vm) of
		  pang->
		     true;
		  _Err->
		      timer:sleep(SleepTime),
		      false
	      end,
    check_stopped(N-1,Vm,SleepTime,NewResult).


% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
