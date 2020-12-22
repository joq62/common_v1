%%% -------------------------------------------------------------------
%%% @author  : Joq Erlang
%%% @doc: : 
%%%  c
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(vm). 


-export([create/4,create/5,
	 delete/2,
	 stop_vm/2
	]).




%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
delete(Vm,VmDir)->
    DeleteDir=rpc:call(Vm,file,del_dir_r,[VmDir],3000),
    InitStop= rpc:call(Vm,init,stop,[],3000),
    timer:sleep(200),
    {DeleteDir,InitStop}.

%% --------------------------------------------------------------------
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

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
create(HostId,VmId,VmDir,Cookie)->
    Result=case if_db:computer_read(HostId) of
	       []->
		   {error,[eexists, HostId,?MODULE,?LINE]};
	       [{HostId,User,PassWd,Ip,Port,running}]->
		   create_vm(User,PassWd,Ip,Port,HostId,VmId,VmDir,Cookie);
	       [{HostId,_User,_PassWd,_Ip,_Port,State}]->
		   {error,[error_state, HostId,State,?MODULE,?LINE]}
	   end,
    Result.
create(HostId,VmId,VmDir,Cookie,PreLoadedServices)->
    Result=case create(HostId,VmId,VmDir,Cookie) of
	       {error,Err}->
		   {error,Err};
	       {ok,_}->
		   ServiceInfo=lists:append([if_db:service_def_read(ZServiceId,ZServiceVsn)||
						{ZServiceId,ZServiceVsn}<-PreLoadedServices]),
		   StartResult=[{misc_cmn:create_service(Vm,XVmDir,ServiceId,ServiceVsn,StartMFA,GitPath),ServiceId,ServiceVsn}||
		       {Vm,XVmDir,ServiceId,ServiceVsn,StartMFA,GitPath}<-ServiceInfo],
		   StartResult
	   end,
    Result.


create_vm(User,PassWd,Ip,Port,HostId,VmId,VmDir,Cookie)->
    Vm=list_to_atom(VmId++"@"++HostId),
    true=stop_vm(Vm),  
    Reply=case my_ssh:ssh_send(Ip,Port,User,PassWd,"erl -sname "++VmId++" -setcookie "++Cookie++" -detached",5000) of
	      ok->
		  case vm_started(Vm) of
		      false->
			  {error,[ecreate_vm,Vm]};
		      true->
			  case rpc:call(Vm,filelib,is_dir,[VmDir],3000) of
			      false->
				  ok;
			      true ->
				  case rpc:call(Vm,file,del_dir_r,[VmDir],3000) of
				      ok->
					  case rpc:call(Vm,file,make_dir,[VmDir],3000) of
					      ok->
						  {ok,Vm};
					      {error,Reason} ->
						  stop_vm(Vm),
						  {error,Reason}
					  end;
				      {error,Reason} ->
					  stop_vm(Vm),
					  {error,Reason}
				  end;
			      {error,Reason} ->
				  stop_vm(Vm),
				  {error,Reason}
			  end;
		      {error,Reason} ->
			  stop_vm(Vm),
			  {error,Reason}
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
