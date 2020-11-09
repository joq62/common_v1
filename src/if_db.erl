%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(if_db).  
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
 
%%---------------------------------------------------------------------
%% Records for test
%%

%% --------------------------------------------------------------------
-compile(export_all).

-define(DbaseVmId,"10250").


%% ====================================================================
%% External functions
%% ====================================================================

% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
deployment_spec_create({db_deployment_spec,DeplId,SpecId,Vsn,Date,Time,SdList})->
    deployment_spec_create(DeplId,SpecId,Vsn,Date,Time,SdList).
deployment_spec_create(DeplId,SpecId,Vsn,Date,Time,SdList)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_deployment_spec,create,[DeplId,SpecId,Vsn,Date,Time,SdList],5000).

deployment_spec_read_all()->
 {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_deployment_spec,read_all,[],5000).

deployment_spec_read(SpecId,Vsn)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_deployment_spec,read,[SpecId,Vsn],5000).

deployment_spec_delete(SpecId,Vsn)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_deployment_spec,delete,[SpecId,Vsn],5000).

% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
deployment_create({db_deployment,DeplId,SpecId,Vsn,Date,Time,SdList})->
    deployment_create(DeplId,SpecId,Vsn,Date,Time,SdList).
deployment_create(DeplId,SpecId,Vsn,Date,Time,SdList)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_deployment,create,[DeplId,SpecId,Vsn,Date,Time,SdList],5000).

deployment_read_all()->
 {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_deployment,read_all,[],5000).

deployment_read(DeplId)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_deployment,read,[DeplId],5000).

deployment_delete(DeplId)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_deployment,delete,[DeplId],5000).
% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
log_create({db_log,Vm,Module,Line,Severity,Date,Time,Text})->
    log_create(Vm,Module,Line,Severity,Date,Time,Text).
log_create(Vm,Module,Line,Severity,Date,Time,Text)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_log,create,[Vm,Module,Line,Severity,Date,Time,Text],5000).

log_severity(Severity)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_log,severity,[Severity],5000).

log_latest(Len,all)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_log,log_latest,[Len,all],5000).

log_read_all()->
 {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_log,read_all,[],5000).

log_delete(Vm,Module,Line,Severity,Date,Time,Text)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_log,delete,[Vm,Module,Line,Severity,Date,Time,Text],5000).

% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
computer_status(Status)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_computer,status,[Status],5000).
computer_create({db_computer,HostId,SshId,SshPwd,IpAddr,Port,Status})->
    computer_create(HostId,SshId,SshPwd,IpAddr,Port,Status).
computer_create(HostId,SshId,SshPwd,IpAddr,Port,Status)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_computer,create,[HostId,SshId,SshPwd,IpAddr,Port,Status],5000).
computer_read_all()->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_computer,read_all,[],5000).
computer_read(HostId)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_computer,read,[HostId],5000).
computer_delete(HostId)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_computer,delete,[HostId],5000).
% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
