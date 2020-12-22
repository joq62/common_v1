%%% -------------------------------------------------------------------
%%% @author : joqerlang
%%% @doc : ets dbase for master service to manage app info , catalog  
%%%
%%% -------------------------------------------------------------------
-module(service).
 

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

%-compile(export_all).
-export([create/6
	]).


create(Vm,VmDir,AppId,Vsn,{M,F,A},GitPath)->
    AppDir=string:concat(AppId,misc_cmn:vsn_to_string(Vsn)),
    GitDest=filename:join(VmDir,AppDir),
    CodePath=filename:join([VmDir,AppDir,"ebin"]),
    [AppModule]=A,
    true=vm:vm_started(Vm),
    rpc:call(Vm,file,del_dir_r,[GitDest],3000),
    rpc:call(Vm,os,cmd,["git clone "++GitPath++" "++GitDest],10*1000),
    true=rpc:call(Vm,code,add_patha,[CodePath],3000),
    Result=case rpc:call(Vm,M,F,A,3000) of
	       ok->
		   case rpc:call(Vm,AppModule,ping,[],3000) of
		       {pong,_,AppModule}->
			   ok;
		       Reason->
			   {error,[Reason,?MODULE,?LINE]}
		   end;
	       Reason->
		   {error,[Reason,?MODULE,?LINE]}
	   end,
    Result.

%% ====================================================================
%% External functions
%% ====================================================================


%% --------------------------------------------------------------------
%% 
%%
%% --------------------------------------------------------------------
