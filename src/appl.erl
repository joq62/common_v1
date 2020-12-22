%%% -------------------------------------------------------------------
%%% @author : joqerlang
%%% @doc : ets dbase for master service to manage app info , catalog  
%%%
%%% -------------------------------------------------------------------
-module(appl).
 

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

-compile(export_all).
%-export([deploy/2
%	]).





%% ====================================================================
%% External functions
%% ====================================================================


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------

instances(DepSpecId,DepSpecVsn)->
    Result=case if_db:deployment_spec_read(DepSpecId,DepSpecVsn) of
	       []->
		   {error,[eexists,DepSpecId,DepSpecVsn]};
	       [{_DepSpecId,_DepSpecVsn,NumInstances,_Restrictions,_AppList}] ->
		   {ok,NumInstances};
	       Reason ->
		   {error,[Reason]}
	   end,
    Result.
restrictions(DepSpecId,DepSpecVsn)->
    Result=case if_db:deployment_spec_read(DepSpecId,DepSpecVsn) of
	       []->
		   {error,[eexists,DepSpecId,DepSpecVsn]};
	       [{_DepSpecId,_DepSpecVsn,_NumInstances,Restrictions,_AppList}] ->
		   {ok,Restrictions};
	       Reason ->
		   {error,[Reason]}
	   end,
    Result.
service_info(DepSpecId,DepSpecVsn)->
    Result=case if_db:deployment_spec_read(DepSpecId,DepSpecVsn) of
	       []->
		   {error,[eexists,DepSpecId,DepSpecVsn]};
	       [{_DepSpecId,_DepSpecVsn,_NumInstances,_Restrictions,AppList}] ->
		   [{AppId,AppVsn}]=AppList,
		   case if_db:app_spec_read(AppId,AppVsn) of
		       []->
			   {error,[eexists,AppId,AppVsn]};
		       [{AppId,AppVsn,ServiceList}]->
			   ServiceInfo=lists:append([if_db:service_def_read(ServiceId,ServiceVsn)||{ServiceId,ServiceVsn}<-ServiceList]),
			   case [error||[]<-ServiceInfo] of
			       []->
				   {ok,ServiceInfo};
			       Reason ->
				   {error,[Reason,ServiceInfo]}
			   end;
		       Reason ->
			   {error,[Reason]}
		   end;
	       Reason ->
		   {error,[Reason]}
	   end,
	Result.



deploy()->

    % dep_spec info

    % decide on num instances

    % decided on restrictions 

    % decide on host

    % start vm 

    % start services

    % update service discovery

    % update deployment 

%    StartResult=[{YServiceId,YServiceVsn,HostId,TestVm,VmDir,service:create(TestVm,VmDir,YServiceId,YServiceVsn,YStartCmd,YGitPath)}||{YServiceId,YServiceVsn,YStartCmd,YGitPath}<-ServiceInfo],
    
    % Check if started ok , add to service discovery
 %   [if_db:sd_create(ZServiceId,ZVsn,HostId,VmId,TestVm)||{ZServiceId,ZVsn,_HostId,_TestVm,_VmDir,ok}<-StartResult],

  %  case if_db:deployment_read(DepSpecId,DepSpecVsn) of
%	[]->
%	    if_db:deployment_create(DepSpecId,DepSpecVsn,date(),time(),StartResult);
%	_ ->
%	    if_db:deployment_update(DepSpecId,DepSpecVsn,date(),time(),StartResult)
 %   end,
    
   glurk.


%% --------------------------------------------------------------------
%% 
%%
%% --------------------------------------------------------------------
