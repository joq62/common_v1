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
passwd_create({db_passwd,UserId,PassWd})->
    passwd_create(UserId,PassWd).
passwd_create(UserId,PassWd)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_passwd,create,[UserId,PassWd],5000).

passwd_read_all()->
 {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_passwd,read_all,[],5000).

passwd_read(UserId)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_passwd,read,[UserId],5000).

passwd_update(UserId,NewPwd)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_passwd,update,[UserId,NewPwd],5000).

passwd_delete(UserId)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_passwd,delete,[UserId],5000).


% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
service_def_create({db_service_def,ServiceId,Vsn,GitUserId})->
    service_def_create(ServiceId,Vsn,GitUserId).
service_def_create(ServiceId,Vsn,GitUserId)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_service_def,create,[ServiceId,Vsn,GitUserId],5000).

service_def_read_all()->
 {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_service_def,read_all,[],5000).

service_def_read(ServiceId,Vsn)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_service_def,read,[ServiceId,Vsn],5000).

service_def_update(Id,Vsn,NewVsn,NewSource)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_service_def,update,[Id,Vsn,NewVsn,NewSource],5000).

service_def_delete(Id,Vsn)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_service_def,delete,[Id,Vsn],5000).

% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
sd_create({db_sd,ServiceId,Vsn,HostId,VmId,Vm})->
    sd_create(ServiceId,Vsn,HostId,VmId,Vm).
sd_create(ServiceId,Vsn,HostId,VmId,Vm)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_sd,create,[ServiceId,Vsn,HostId,VmId,Vm],5000).

sd_read(ServiceId)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_sd,read,[ServiceId],5000).
sd_read(ServiceId,Vsn)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_sd,read,[ServiceId,Vsn],5000).

sd_get(ServiceId)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_sd,get,[ServiceId],5000).
sd_get(ServiceId,Vsn)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_sd,get,[ServiceId,Vsn],5000).

sd_read_all()->
 {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_sd,read_all,[],5000).

sd_delete(ServiceId,Vsn,Vm)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_sd,delete,[ServiceId,Vsn,Vm],5000).

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
deployment_create({db_deployment,DeplId,SpecId,Vsn,Date,Time,HostId,VmId,SdList,Status})->
    deployment_create(DeplId,SpecId,Vsn,Date,Time,HostId,VmId,SdList,Status).
deployment_create(DeplId,SpecId,Vsn,Date,Time,HostId,VmId,SdList,Status)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_deployment,create,[DeplId,SpecId,Vsn,Date,Time,HostId,VmId,SdList,Status],5000).

deployment_read_all()->
 {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_deployment,read_all,[],5000).

deployment_read(DeplId)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_deployment,read,[DeplId],5000).



deployment_status(Status)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_deployment,status,[Status],5000).

deployment_update_status(DeplId,NewStatus)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_deployment,update_status,[DeplId,NewStatus],5000).

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

computer_update(HostId,NewStatus)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_computer,update,[HostId,NewStatus],5000).

computer_delete(HostId)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_computer,delete,[HostId],5000).
% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
vm_info(Vm)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_vm,info,[Vm],5000).

vm_host_id(HostId)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_vm,host_id,[HostId],5000).

vm_type(Type)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_vm,type,[Type],5000).

vm_status(Status)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_vm,status,[Status],5000).

vm_create({db_vm,HostId,SshId,SshPwd,IpAddr,Port,Status})->
    vm_create(HostId,SshId,SshPwd,IpAddr,Port,Status).
vm_create(HostId,SshId,SshPwd,IpAddr,Port,Status)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_vm,create,[HostId,SshId,SshPwd,IpAddr,Port,Status],5000).
vm_read_all()->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_vm,read_all,[],5000).
vm_read(HostId)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_vm,read,[HostId],5000).

vm_update(Vm,NewStatus)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_vm,update,[Vm,NewStatus],5000).

vm_delete(HostId)->
    {ok,DbaseHostId}=inet:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++DbaseHostId),
    rpc:call(DbaseVm,db_vm,delete,[HostId],5000).