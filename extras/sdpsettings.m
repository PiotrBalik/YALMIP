function options = sdpsettings(varargin)
%SDPSETTINGS Create/alter solver options structure.
%
%   OPTIONS = SDPSETTINGS with no input arguments returns
%   setting structure with default values
%
%   OPTIONS = SDPSETTINGS('NAME1',VALUE1,'NAME2',VALUE2,...) creates a
%   solution options structure OPTIONS in which the named properties have
%   the specified values.  Any unspecified properties have default values.
%   It is sufficient to type only the leading characters that uniquely
%   identify the property.  Case is ignored for property names.
%
%   OPTIONS = SDPSETTINGS(OLDOPTS,'NAME1',VALUE1,...) alters an existing options
%   structure OLDOPTS.
%
%   The OPTIONS structure is a simple struct and can thus easily be
%   manipulated after its creation
%   OPTIONS = sdpsettings;OPTIONS.verbose = 0;
%
%
%   SDPSETTINGS PROPERTIES
%
%   GENERAL
%
%    solver             - Specify solver [''|sdpt3|sedumi|sdpa|pensdp|penbmi|csdp|dsdp|maxdet|lmilab|cdd|cplex|xpress|mosek|nag|quadprog|linprog|bnb|bmibnb|kypd|mpt|none ('')]
%    verbose            - Display-level [0|1|2|...(0)] (0-silent, 1-normal, >1-loud)
%    usex0              - Use the current values obtained from double as initial iterate if solver supports that [0|1 (0)]
%
%    showprogress       - Show progress of YALMIP (suitable for large problems) [0|1 (0)]
%    cachesolvers       - Check for available solvers only first time solvesdp is called [0|1 (0)]
%    warning            - Shows a warning if a problems occurs when solving a problem (infeasibility, numerical problem etc.) [0|1 (1)]
%    beeponproblem      - Beeps when certain warning/error occurs [ integers -2|-1|1|2|3|4|5|6|7|8|9|10|11]
%    saveduals          - Dual variables are saved in YALMIP [0|1 (1)]
%    saveyalmipmodel    - Keep all data sent to solver interface [0|1 (0)]
%    savesolverinput    - Keep all data sent to solver [0|1 (0)]
%    savesolveroutput   - Keep all data returned from solver [0|1 (0)]
%    removeequalities   - Let YALMIP remove equality constraints [-1|0|1 (0)] (-1:with double inequalities, 0:don't, 1:by QR decomposition, 2:basis from constraints)
%    convertconvexquad  - Convert convex quadratic constraints to second order cones [0|1 (1)]
%    radius             - Add radius constraint on all pimal variables ||x||<radius [double >=0 (inf)]
%    shift              - Add small perturbation to (try to) enforce strict feasibility [double >=0 (0)]
%    relax              - Disregard integrality constraint and/or relax nonlinear terms  [0 | 1 (both) 2 (relax integrality) 3 (relax nonlinear terms) (0)]
%    allowmilp          - Allow introduction of binary variables to model nonlinear operators [0 | 1 (0)]
%    expand             - Expand nonlinear operators [0|1 (1)]. Should always be true except in rare debugging cases.
%    plot               - Options when plotting sets
%
%   SUM-OF-SQUARES
%
%    sos, see help solvesos
%
%   BRANCH AND BOUND for mixed integer programs
%
%    options.bnb, see help bnb
%
%   BRANCH AND BOUND for polynomial programs
%
%    options.bmibnb, see help bmibnb
%
%   EXTERNAL SOLVERS
%
%    See solver manuals.

% Print out possible values of properties.
if (nargin == 0) && (nargout == 0)
    help sdpsettings
    return;
end

if (nargin>0) && isstruct(varargin{1})
    options = varargin{1};
    Names = recursivefieldnames(options);
    paramstart = 2;
else
    Names = {};
    paramstart = 1;
    
    options = setup_core_options;
    Names = appendOptionNames(Names,options);
    
    % Internal solver frameworks
    options.bilevel = setup_bilevel_options;
    Names = appendOptionNames(Names,options.bilevel,'bilevel');
    
    options.bmibnb = setup_bmibnb_options;
    Names = appendOptionNames(Names,options.bmibnb,'bmibnb');
    
    options.bnb = setup_bnb_options;
    Names = appendOptionNames(Names,options.bnb,'bnb');
    
    options.cutsdp = setup_cutsdp_options;
    Names = appendOptionNames(Names,options.cutsdp,'cutsdp');
    
    options.kkt = setup_kkt_options;
    Names = appendOptionNames(Names,options.kkt,'kkt');
    
    options.moment = setup_moment_options;
    Names = appendOptionNames(Names,options.moment,'moment');
    
    options.mp = setup_mp_options;
    Names = appendOptionNames(Names,options.mp,'mp');
    
    options.mpcvx = setup_mpcvx_options;
    Names = appendOptionNames(Names,options.mpcvx,'mpcvx');
    
    options.plot = setup_plot_options;
    Names = appendOptionNames(Names,options.plot,'plot');
    
    options.robust = setup_robust_options;
    Names = appendOptionNames(Names,options.robust,'robust');
    
    options.sos = setup_sos_options;
    Names = appendOptionNames(Names,options.sos,'sos');
    
    % External solvers
    options.baron = setup_baron_options;
    Names = appendOptionNames(Names,options.baron,'baron');
    
    options.bintprog = setup_bintprog_options;
    Names = appendOptionNames(Names,options.bintprog,'bintprog');
    
    options.bonmin = setup_bonmin_options;
    Names = appendOptionNames(Names,options.bonmin,'bonmin');
    
    options.cdd = setup_cdd_options;
    Names = appendOptionNames(Names,options.cdd,'cdd');
    
    options.cbc = setup_cbc_options;
    Names = appendOptionNames(Names,options.cbc,'cbc');
    
    options.clp = setup_clp_options;
    Names = appendOptionNames(Names,options.clp,'clp');
    
    options.cplex = setup_cplex_options;
    Names = appendOptionNames(Names,options.cplex,'cplex');
    
    options.csdp = setup_csdp_options;
    Names = appendOptionNames(Names,options.csdp,'csdp');
    
    options.dsdp = setup_dsdp_options;
    Names = appendOptionNames(Names,options.dsdp,'dsdp');
    
    options.ecos = setup_ecos_options;
    Names = appendOptionNames(Names,options.ecos,'ecos');
    
    options.filtersd = setup_filtersd_options;
    Names = appendOptionNames(Names,options.filtersd,'filtersd');
    
    options.fmincon = setup_fmincon_options;
    Names = appendOptionNames(Names,options.fmincon,'fmincon');
    
    options.fminsearch = setup_fminsearch_options;
    Names = appendOptionNames(Names,options.fminsearch,'fminsearch');
    
    options.frlib = setup_frlib_options;
    Names = appendOptionNames(Names,options.frlib,'frlib');
    
    options.glpk = setup_glpk_options;
    Names = appendOptionNames(Names,options.glpk,'glpk');
    
    options.gurobi = setup_gurobi_options;
    Names = appendOptionNames(Names,options.gurobi,'gurobi');
    
    options.ipopt = setup_ipopt_options;
    Names = appendOptionNames(Names,options.ipopt,'ipopt');
    
    options.intlinprog = setup_intlinprog_options;
    Names = appendOptionNames(Names,options.intlinprog,'intlinprog');
    
    options.knitro = setup_knitro_options;
    Names = appendOptionNames(Names,options.knitro,'knitro');
    
    options.linprog = setup_linprog_options;
    Names = appendOptionNames(Names,options.linprog,'linprog');
    
    options.lmilab = setup_lmilab_options;
    Names = appendOptionNames(Names,options.lmilab,'lmilab');
    
    options.lmirank = setup_lmirank_options;
    Names = appendOptionNames(Names,options.lmirank,'lmirank');
    
    options.logdetppa = setup_logdetppa_options;
    Names = appendOptionNames(Names,options.logdetppa,'logdetppa');
    
    options.lpsolve = setup_lpsolve_options;
    Names = appendOptionNames(Names,options.lpsolve,'lpsolve');
    
    options.lsqnonneg = setup_lsqnonneg_options;
    Names = appendOptionNames(Names,options.lsqnonneg,'lsqnonneg');
    
    options.lsqlin = setup_lsqlin_options;
    Names = appendOptionNames(Names,options.lsqlin,'lsqlin');
    
    options.kypd = setup_kypd_options;
    Names = appendOptionNames(Names,options.kypd,'kypd');
    
    options.nag = setup_nag_options;
    Names = appendOptionNames(Names,options.nag,'nag');
    
    options.mosek = setup_mosek_options;
    Names = appendOptionNames(Names,options.mosek,'mosek');
    
    options.nomad = setup_nomad_options;
    Names = appendOptionNames(Names,options.nomad,'nomad');
    
    options.ooqp = setup_ooqp_options;
    Names = appendOptionNames(Names,options.ooqp,'ooqp');
    
    options.scip = setup_scip_options;
    Names = appendOptionNames(Names,options.scip,'scip');
        
    options.scs = setup_scs_options;
    Names = appendOptionNames(Names,options.scs,'scs');
    
    options.sdpa = setup_sdpa_options;
    Names = appendOptionNames(Names,options.sdpa,'sdpa');
    
    options.sdplr = setup_sdplr_options;
    Names = appendOptionNames(Names,options.sdplr,'sdplr');
    
    options.sdpt3 = setup_sdpt3_options;
    Names = appendOptionNames(Names,options.sdpt3,'sdpt3');
    
    options.sdpnal = setup_sdpnal_options;
    Names = appendOptionNames(Names,options.sdpnal,'sdpnal');
    
    options.sedumi = setup_sedumi_options;
    Names = appendOptionNames(Names,options.sedumi,'sedumi');
    
    options.sparsepop = setup_sparsepop_options;
    Names = appendOptionNames(Names,options.sparsepop,'sparsepop');
    
    options.sparsecolo = setup_sparsecolo_options;
    Names = appendOptionNames(Names,options.sparsecolo,'sparsecolo');
    
    options.vsdp = setup_vsdp_options;
    Names = appendOptionNames(Names,options.vsdp,'vsdp');
    
    options.qpoases = setup_qpoases_options;
    Names = appendOptionNames(Names,options.qpoases,'qpoases');
    
    options.qsopt = setup_qsopt_options;
    Names = appendOptionNames(Names,options.qsopt,'qsopt');
    
    options.quadprog = setup_quadprog_options;
    Names = appendOptionNames(Names,options.quadprog,'quadprog');
    
    options.quadprogbb = setup_quadprogbb_options;
    Names = appendOptionNames(Names,options.quadprogbb,'quadprogbb');
    
    options.xpress = setup_xpress_options;
    Names = appendOptionNames(Names,options.xpress,'xpress');
end

names = lower(Names);
i = paramstart;
% A finite state machine to parse name-value pairs.
if rem(nargin-i+1,2) ~= 0
    error('Arguments must occur in name-value pairs.');
end
expectval = 0;                          % start expecting a name, not a value
while i <= nargin
    arg = varargin{i};
    
    if ~expectval
        if ~ischar(arg)
            error(sprintf('Expected argument %d to be a string property name.', i));
        end
        
        lowArg = lower(arg);
        
        j = strmatch(lowArg,names);
        if isempty(j)                       % if no matches
            error(sprintf('Unrecognized property name ''%s''.', arg));
        elseif length(j) > 1                % if more than one match
            % Check for any exact matches (in case any names are subsets of others)
            k = strmatch(lowArg,names,'exact');
            if (length(k) == 1)
                j = k;
            else
                msg = sprintf('Ambiguous property name ''%s'' ', arg);
                msg = [msg '(' deblank(Names{j(1)})];
                for k = j(2:length(j))'
                    msg = [msg ', ' deblank(Names{k})];
                end
                msg = sprintf('%s).', msg);
                error(msg);
            end
        end
        expectval = 1;                      % we expect a value next
    else
        eval(['options.' Names{j} '= arg;']);
        expectval = 0;
    end
    i = i + 1;
end

if expectval
    error(sprintf('Expected value for property ''%s''.', arg));
end


function [solverops] = trytoset(solver)

try
    try
        evalc(['solverops = ' solver '(''defaults'');']);
    catch
        solverops = optimset(solver);
    end
catch
    solverops = optimset;
end

% if isequal(solver, 'quadprog') && isfield(solverops, 'Algorithm') && ~isempty(solverops.Algorithm)
%     solverops.Algorithm = 'active-set';
% end
%
% if  any(strcmp(solvernames,'LargeScale'))
%     if isequal(solver, 'quadprog')
%         solverops.LargeScale = 'off';
%     end
% else
%     solvernames{end+1} = 'LargeScale';
%     solverops.LargeScale = 'off';
% end



function cNames = recursivefieldnames(options,append);

if nargin == 1
    append = '';
end

cNames = fieldnames(options);
for i = 1:length(cNames)
    eval(['temporaryOptions = options.' cNames{i} ';']);
    if isa(temporaryOptions,'struct')
        cNames = [cNames;recursivefieldnames(temporaryOptions,[cNames{i}])];
    end
end
for i = 1:length(cNames)
    if nargin==1
    else
        cNames{i} = [append '.' cNames{i}];
    end
end

function  Names = appendOptionNames(Names,options,solver)
if ~isempty(options)
    if ~isa(options,'struct')
        % Hide warning
        evalc(['options = struct(options);']);
    end
    cNames = recursivefieldnames(options);
    if nargin == 3
        prefix = [solver '.'];
    else
        prefix = [];
    end
    for i = 1:length(cNames)
        Names{end+1} = [prefix  cNames{i}];
    end
end

function options = setup_core_options
options.solver = '';
options.verbose = 1;
options.debug = 0;
options.usex0 = 0;
options.warning = 1;
options.cachesolvers = 0;
options.showprogress = 0;
options.saveduals = 1;
options.removeequalities = 0;
options.savesolveroutput = 0;
options.savesolverinput  = 0;
options.saveyalmipmodel  = 0;
options.convertconvexquad = 1;
options.radius = inf;
options.relax = 0;
options.dualize = 0;
options.usex0 = 0;
options.savedebug = 0;
options.debug = 0;
options.expand = 1;
options.allowmilp = 1;
options.allownonconvex = 1;
options.shift = 0;
options.dimacs = 0;
options.beeponproblem = [-5 -4 -3 -2 -1];

function bilevel = setup_bilevel_options
bilevel.algorithm = 'internal';
bilevel.maxiter = 1e4;
bilevel.outersolver = '';
bilevel.innersolver = '';
bilevel.rootcuts = 0;
bilevel.solvefrp = 0;
bilevel.relgaptol = 1e-3;
bilevel.feastol = 1e-6;
bilevel.compslacktol = 1e-8;
function bmibnb = setup_bmibnb_options
bmibnb.branchmethod = 'best';
bmibnb.branchrule = 'omega';
bmibnb.cut.multipliedequality = 0;
bmibnb.cut.convexity = 0;
bmibnb.cut.evalvariable = 1;
bmibnb.cut.bilinear = 1;
bmibnb.cut.monomial = 1;
bmibnb.cut.complementarity = 1;
bmibnb.sdpcuts = 0;
bmibnb.lpreduce = 1;
bmibnb.lowrank  = 0;
bmibnb.diagonalize  = 1;
bmibnb.lowersolver = '';
bmibnb.uppersolver = '';
bmibnb.lpsolver = '';
bmibnb.target =  -inf;
bmibnb.lowertarget =  inf;
bmibnb.vartol = 1e-3;
bmibnb.relgaptol = 1e-2;
bmibnb.absgaptol = 1e-2;
bmibnb.pdtol = -1e-6;
bmibnb.eqtol = 1e-6;
bmibnb.maxiter = 100;
bmibnb.maxtime = 3600;
bmibnb.roottight = 1;
bmibnb.numglobal = inf;
bmibnb.localstart = 'relaxed';
bmibnb.presolvescheme = [];
bmibnb.strengthscheme = [1 2 1 3 1 4 1 6 1 5 1 4 1 6 1 4 1];
function bnb = setup_bnb_options
bnb.branchrule = 'max';
bnb.method = 'depthbest';
bnb.verbose = 1;
bnb.solver = '';
bnb.uppersolver = 'rounder';
bnb.presolve = 0;
bnb.inttol = 1e-4;
bnb.feastol = 1e-7;
bnb.gaptol = 1e-4;
bnb.weight = [];
bnb.nodetight = 0;
bnb.nodefix = 0;
bnb.ineq2eq = 0;
bnb.plotbounds = 0;
bnb.rounding = {'ceil','floor','round','shifted round','fix'};
bnb.round = 1;
bnb.maxiter = 300;
bnb.prunetol = 1e-4;
bnb.multiple = 0;
bnb.profile = 0;
function cutsdp = setup_cutsdp_options
cutsdp.solver = '';
cutsdp.maxiter = 100;
cutsdp.cutlimit = inf;
cutsdp.feastol = -1e-8;
cutsdp.recoverdual = 0;
cutsdp.variablebound = inf;
cutsdp.nodefix = 0;
cutsdp.nodetight = 0;
function frlib = setup_frlib_options
frlib.approximation = 'd';
frlib.reduce = 'auto';
frlib.solver = '';
frlib.solverPreProcess = '';
frlib.useQR = 0;
frlib.removeDualEq = 1;
function kkt = setup_kkt_options
kkt.dualbounds = 1;
kkt.dualpresolve.passes = 1;
kkt.dualpresolve.lplift = 1;
kkt.minnormdual = 0;
kkt.licqcut = 0;
function moment = setup_moment_options
moment.order = [];
moment.blockdiag = 0;
moment.solver = '';
moment.refine = 0;
moment.extractrank = 0;
moment.rceftol = -1;
function mpcvx = setup_mpcvx_options
mpcvx.solver = '';
mpcvx.absgaptol = 0.25;
mpcvx.relgaptol = 0.01;
mpcvx.plot = 0;
mpcvx.rays = 'n*20';
function mp = setup_mp_options
mp.algorithm = 1;
mp.simplify  = 0;
mp.presolve  = 0;
mp.unbounded = 0;
function plot = setup_plot_options
plot.edgecolor = 'k';
plot.wirestyle = '-';
plot.wirecolor = 'k';
plot.linewidth = 0.5;
plot.shade = 1;
plot.waitbar = 1;
function robust = setup_robust_options
robust.lplp = 'enumeration';
robust.coniconic.tau_degree = 2;
robust.coniconic.gamma_degree = 0;
robust.coniconic.Z_degree = 2;
robust.auxreduce = 'none';
robust.reducedual = 0;
robust.reducesemiexplicit = 0;
robust.polya = nan;
function sos = setup_sos_options
sos.model = 0;
sos.newton = 1;
sos.congruence = 2;
sos.scale = 1;
sos.numblkdg = 0;
sos.postprocess = 0;
sos.csp = 0;
sos.extlp = 1;
sos.impsparse = 0;
sos.sparsetol = 1e-5;
sos.inconsistent = 0;
sos.clean = eps;
sos.savedecomposition = 1;
sos.traceobj = 0;
sos.reuse = 1;

function bpmpd = setup_bpmpd_options
try
    bpmpd.opts = bpopt;
catch
    bpmpd.opts =[];
end

function cbc = setup_cbc_options
try
    cbc = cbcset;
catch
    cbc.tolint = 1e-4;
    cbc.maxiter = 10000;
    cbc.maxnodes = 100000;
end

function cdd = setup_cdd_options
cdd.method = 'criss-cross';

function clp = setup_clp_options
try
    clp = clpset;
catch
    clp.solver = 1;
    clp.maxnumiterations = 99999999;
    clp.maxnumseconds = 3600;
    clp.primaltolerance  = 1e-7;
    clp.dualtolerance    = 1e-7;
    clp.primalpivot = 1;
    clp.dualpivot = 1;
end

function cplex = setup_cplex_options
try
    cplex = cplexoptimset('cplex');
    cplex.output.clonelog = 0;
catch
    cplex.presol = 1;
    cplex.niter = 1;
    cplex.epgap = 1e-4;
    cplex.epagap = 1e-6;
    cplex.relobjdif = 0.0;
    cplex.objdif = 0.0;
    cplex.tilim = 1e75;
    cplex.logfile = 0;
    cplex.param.double = [];
    cplex.param.int = [];
end

function ecos = setup_ecos_options
ecos.feastol = 1e-5;
ecos.abstol = 1e-6;
ecos.reltol = 1e-6;
ecos.maxit = 30;

function filtersd = setup_filtersd_options
filtersd.maxiter = 1500;
filtersd.maxtime = 1000;
filtersd.maxfeval = 10000;

function glpk = setup_glpk_options
glpk.lpsolver = 1;
glpk.scale = 1;
glpk.dual = 0;
glpk.price = 1;
glpk.relax = 0.07;
glpk.tolbnd = 1e-7;
glpk.toldj = 1e-7;
glpk.tolpiv = 1e-9;
glpk.round = 0;
glpk.objll = -1e12;
glpk.objul = 1e12;
glpk.itlim = 1e4;
glpk.tmlim = -1;
glpk.branch = 2;
glpk.btrack = 2;
glpk.tolint = 1e-6;
glpk.tolobj = 1e-7;
glpk.presol = 1;
glpk.save = 0;

function gurobi = setup_gurobi_options
gurobi.BarIterLimit = inf;
gurobi.Cutoff = inf;
gurobi.IterationLimit = inf;
gurobi.NodeLimit = inf;
gurobi.SolutionLimit = inf;
gurobi.TimeLimit = inf;
gurobi.BarConvTol = 1e-8;
gurobi.BarQCPConvTol = 1e-6;
gurobi.FeasibilityTol = 1e-6;
gurobi.IntFeasTol = 1e-6;
gurobi.MarkowitzTol = 0.0078125;
gurobi.MIPGap = 1e-4;
gurobi.MIPGapAbs = 1e-10;
gurobi.OptimalityTol = 1e-6;
gurobi.PSDTol = 1e-6;
gurobi.InfUnbdInfo = 0;
gurobi.NormAdjust = -1;
gurobi.ObjScale = 0;
gurobi.PerturbValue = 0.0002;
gurobi.Quad = -1;
gurobi.ScaleFlag = 1;
gurobi.Sifting = -1;
gurobi.SiftMethod = -1;
gurobi.SimplexPricing = -1;
gurobi.BarCorrectors = -1;
gurobi.BarHomogeneous = -1;
gurobi.BarOrder = -1;
gurobi.Crossover = -1;
gurobi.CrossoverBasis = 0;
gurobi.QCPDual = 0;
gurobi.BranchDir = 0;
gurobi.ConcurrentMIP = 1;
gurobi.Heuristics = 0.05;
gurobi.ImproveStartGap = 0;
gurobi.ImproveStartNodes = inf;
gurobi.ImproveStartTime = inf;
gurobi.MinRelNodes = 0;
gurobi.MIPFocus = 0;
gurobi.MIQCPMethod = -1;
gurobi.NodefileDir = '.';
gurobi.NodefileStart = inf;
gurobi.NodeMethod = 1;
gurobi.PumpPasses = 0;
gurobi.RINS = -1;
gurobi.SolutionNumber = 0;
gurobi.SubMIPNodes = 500;
gurobi.Symmetry = -1;
gurobi.VarBranch = -1;
gurobi.ZeroObjNodes = 0;
gurobi.TuneOutput = 2;
gurobi.TuneResults = -1;
gurobi.TuneTimeLimit = -1;
gurobi.TuneTrials = 2;
gurobi.Cuts = -1;
gurobi.CliqueCuts = -1;
gurobi.CoverCuts = -1;
gurobi.FlowCoverCuts = -1;
gurobi.FlowPathCuts = -1;
gurobi.GUBCoverCuts = -1;
gurobi.ImpliedCuts = -1;
gurobi.MIPSepCuts = -1;
gurobi.MIRCuts = -1;
gurobi.ModKCuts = -1;
gurobi.NetworkCuts = -1;
gurobi.SubMIPCuts = -1;
gurobi.ZeroHalfCuts = -1;
gurobi.CutAggPasses = -1;
gurobi.CutPasses = -1;
gurobi.GomoryPasses = -1;
gurobi.AggFill = 10;
gurobi.Aggregate = 1;
gurobi.DisplayInterval = 5;
gurobi.DualReductions = 1;
gurobi.FeasRelaxBigM = 1e6;
gurobi.IISMethod = -1;
gurobi.LogFile = '';
gurobi.Method = -1;
gurobi.NonBlocking = 0;
gurobi.NumericFocus = 0;
gurobi.PreCrush = 0;
gurobi.PreDepRow = -1;
gurobi.PreDual = -1;
gurobi.PreMIQPMethod = -1;
gurobi.PreQLinearize = -1;
gurobi.PrePasses = -1;
gurobi.Presolve = -1;
gurobi.PreSparsify = 0;
gurobi.ResultFile = '';
gurobi.Threads = 0;

function intlinprog = setup_intlinprog_options
try
    intlinprog = optimoptions('intlinprog');
    if ~isa(intlinprog,'struct');
        evalc(['intlinprog = struct(intlinprog);']);
    end
catch
    intlinprog = [];
end

function kypd = setup_kypd_options
kypd.solver = '';
kypd.lyapunovsolver = 'schur';
kypd.reduce = 0;
kypd.transform = 0;
kypd.rho = 1;
kypd.tol = 1e-8;
kypd.lowrank = 0;

function lmilab = setup_lmilab_options
lmilab.reltol = 1e-3;
lmilab.maxiter = 100;
lmilab.feasradius = 1e9;
lmilab.L = 10;

function lmirank = setup_lmirank_options
lmirank.solver = '';
lmirank.maxiter = 100;
lmirank.maxiter = 1000;
lmirank.eps = 1e-9;
lmirank.itermod = 1;

function logdetppa = setup_logdetppa_options
logdetppa.tol = 1e-6;
logdetppa.sig = 10;
logdetppa.maxiter    = 100;
logdetppa.maxitersub = 30;
logdetppa.precond    = 1;
logdetppa.maxitpsqmr = 100;
logdetppa.stagnate_check_psqmr = 0;
logdetppa.scale_data = 2;
logdetppa.plotyes    = 0;
logdetppa.use_proximal = 1;
logdetppa.switch_alt_newton_tol = 1e-2;

function lpsolve = setup_lpsolve_options
lpsolve.scalemode = 0;

function nag = setup_nag_options
nag.featol = sqrt(eps);
nag.itmax = 500;
nag.bigbnd = 1e10;
nag.orthog = 0;

function penbmi = setup_penbmi_options
penbmi.DEF = 1;
penbmi.PBM_MAX_ITER = 50;
penbmi.UM_MAX_ITER = 100;
penbmi.OUTPUT = 1;
penbmi.DENSE = 1;          %!0
penbmi.LS = 0;
penbmi.XOUT = 0;
penbmi.UOUT = 0;
penbmi.NWT_SYS_MODE = 0;
penbmi.PREC_TYPE = 0;
penbmi.DIMACS = 0;
penbmi.TR_MODE = 0;
penbmi.U0 = 1;
penbmi.MU = 0.7;
penbmi.MU2 = 0.5;          %!0.1
penbmi.PRECISION = 1e-6;     %!1e-7
penbmi.P_EPS = 1e-4;       %!1e-6
penbmi.UMIN = 1e-14;
penbmi.ALPHA = 1e-2;
penbmi.P0 = 0.1;           %!0.01
penbmi.PEN_UP = 0.5;       %!0
penbmi.ALPHA_UP = 1.0;
penbmi.PRECISION_2 = 1e-6; %!1e-7
penbmi.CG_TOL_DIR = 5e-2;

function penlab = setup_penlab_options
try
    penlab = penlab.defopts(1);
catch
    penlab = [];
end

function pennlp = setup_pennlp_options
pennlp.maxit = 100;
pennlp.nwtiters = 100;
pennlp.hessianmode = 0;
pennlp.autoscale = 1;
pennlp.convex = 0;
pennlp.eqltymode = 1;
pennlp.ignoreinit = 0;
pennlp.ncmode = 0;
pennlp.nwtstopcrit = 2;
pennlp.penalty = 0;
pennlp.nwtmode = 0;
pennlp.prec = 0;
pennlp.cmaxnzs =-1;
pennlp.autoini = 1;
pennlp.ipenup = 1;
pennlp.precision = 1e-7;
pennlp.uinit = 1;
pennlp.pinit = 1;
pennlp.alpha = 0.01;
pennlp.mu = 0.5;
pennlp.dpenup = 0.1;
pennlp.peps = 1e-8;
pennlp.umin = 1e-12;
pennlp.preckkt = 1e-1;
pennlp.cgtolmin = 5e-2;
pennlp.cgtolup = 1;
pennlp.uinitbox = 1;
pennlp.uinitnc = 1;

function pensdp = setup_pensdp_options
pensdp.DEF = 1;
pensdp.PBM_MAX_ITER = 50;
pensdp.UM_MAX_ITER = 100;
pensdp.OUTPUT = 1;
pensdp.DENSE = 0;
pensdp.LS = 0;
pensdp.XOUT = 0;
pensdp.UOUT = 0;
pensdp.U0 = 1;
pensdp.MU = 0.7;
pensdp.MU2 = 0.1;
pensdp.PBM_EPS = 1e-7;
pensdp.P_EPS = 1e-6;
pensdp.UMIN = 1e-14;
pensdp.ALPHA = 1e-2;
pensdp.P0 = 0.9;

function sparsecolo = setup_sparsecolo_options
sparsecolo.SDPsolver = '';
sparsecolo.domain = 2;
sparsecolo.range = 1;
sparsecolo.EQorLMI = 2;

function sparsepop = setup_sparsepop_options
sparsepop.relaxOrder = 1;
sparsepop.sparseSW = 1;
sparsepop.multiCliquesFactor = 1;
sparsepop.scalingSW = 1;
sparsepop.boundSW = 2;
sparsepop.eqTolerance = 0;
sparsepop.perturbation = 0;
sparsepop.reduceMomentMatSW = 1;
sparsepop.complementaritySW = 0;
sparsepop.reduceAMatSW = 1;
sparsepop.SDPsolver = 'sedumi';
sparsepop.SDPsolverSW = 1;
sparsepop.SDPsolverEpsilon = 1.0000e-009;
sparsepop.SDPsolverOutFile = 0;
sparsepop.sdpaDataFile = '';
sparsepop.matFile = '';
sparsepop.POPsolver = '';
sparsepop.detailedInfFile = '';
sparsepop.printFileName = 1;
sparsepop.errorBdIdx = '';
sparsepop.fValueUbd = '';
sparsepop.symbolicMath = 1;
sparsepop.mex = 0;

function sdpnal = setup_sdpnal_options
sdpnal.tol = 1e-6;
sdpnal.sigma = 10;
sdpnal.maxiter = 100;
sdpnal.maxitersub = 20;
sdpnal.AAtsolve = 2;
sdpnal.precond = 1;
sdpnal.maxitpsqmr = 100;
sdpnal.stagnate_check_psqmr = 0;
sdpnal.scale_data = 2;
sdpnal.plotyes = 0;
sdpnal.proximal = 1;

function sedumi = setup_sedumi_options
sedumi.alg    = 2;
sedumi.beta   = 0.5;
sedumi.theta  = 0.25;
sedumi.free   = 1;
sedumi.sdp    = 0;
sedumi.stepdif= 0;
sedumi.w      = [1 1];
sedumi.mu     = 1.0;
sedumi.eps    = 1e-9;
sedumi.bigeps = 1e-3;
sedumi.maxiter= 150;
sedumi.vplot  = 0;
sedumi.stopat     = -1;
sedumi.denq   = 0.75;
sedumi.denf   = 10;
sedumi.numtol = 5e-7;
sedumi.bignumtol = 0.9;
sedumi.numlvlv = 0;
sedumi.chol.skip = 1;
sedumi.chol.canceltol = 1e-12;
sedumi.chol.maxu   = 5e5;
sedumi.chol.abstol = 1e-20;
sedumi.chol.maxuden= 5e2;
sedumi.cg.maxiter = 25;
sedumi.cg.restol  = 5e-3;
sedumi.cg.refine  = 1;
sedumi.cg.stagtol = 5e-14;
sedumi.cg.qprec   = 0;
sedumi.maxradius = inf;

function sdpt3 = setup_sdpt3_options
sdpt3.vers     = 1;
sdpt3.gam      = 0;
sdpt3.predcorr = 1;
sdpt3.expon    = 1;
sdpt3.gaptol   = 1e-7;
sdpt3.inftol   = 1e-7;
sdpt3.steptol  = 1e-6;
sdpt3.maxit    = 50;
sdpt3.stoplevel= 1;
sdpt3.sw2PC_tol  = inf;
sdpt3.use_corrprim  = 0;
sdpt3.printyes   = 1;
sdpt3.scale_data = 0;
sdpt3.schurfun   = [];
sdpt3.schurfun_parms = [];
sdpt3.randnstate = 0;
sdpt3.spdensity   = 0.5;
sdpt3.rmdepconstr = 0;
sdpt3.CACHE_SIZE = 256;
sdpt3.LOOP_LEVEL = 8;
sdpt3.cachesize = 256;
sdpt3.linsys_options = 'raugmatsys';
sdpt3.smallblkdim = 30;

function quadprogbb = setup_quadprogbb_options
quadprogbb.max_time = 86400;
quadprogbb.fathom_tol = 1e-6;
quadprogbb.tol = 1e-8;
quadprogbb.use_quadprog = 1;
quadprogbb.use_single_processor = 0;
quadprogbb.max_time = inf;

function qpip = setup_qpip_options
qpip.mu = 0.0;
qpip.method = 1;

function qsopt = setup_qsopt_options
try
    qsopt = optiset('solver','qsopt');
catch
    qsopt.dual = 0;
    qsopt.primalprice = 1;
    qsopt.dualprice = 6;
    qsopt.scale = 1;
    qsopt.maxiter = 300000;
    qsopt.maxtime = 10000.0;
end

function sdpa = setup_sdpa_options
sdpa.maxIteration = 100 ;
sdpa.epsilonStar = 1.0E-7;
sdpa.lambdaStar  = 1.0E2  ;
sdpa.omegaStar  = 2.0 ;
sdpa.lowerBound  = -1.0E5  ;
sdpa.upperBound  = 1.0E5  ;
sdpa.betaStar  = 0.1  ;
sdpa.betaBar  = 0.2 ;
sdpa.gammaStar  = 0.9 ;
sdpa.epsilonDash  = 1.0E-7 ;
sdpa.isSymmetric = 0 ;

function sdplr = setup_sdplr_options
sdplr.feastol = 1e-5;
sdplr.centol = 1e-1;
sdplr.dir = 1;
sdplr.penfac = 2;
sdplr.reduce = 0;
sdplr.limit = 3600;
sdplr.soln_factored = 0;
sdplr.maxrank = 0;

function vsdp = setup_vsdp_options
vsdp.solver = '';
vsdp.verifiedupper = 0;
vsdp.verifiedlower = 1;
vsdp.prove_D_infeasible = 0;
vsdp.prove_P_infeasible = 0;

function ipopt = setup_ipopt_options
try
    ipopt = ipoptset;
    ipopt.hessian_approximation = 'limited-memory';
    ipopt.max_iter = 1500;
    ipopt.max_cpu_time = 1000;
    ipopt.tol = 1e-7;
catch
    ipopt.mu_strategy = 'adaptive';
    ipopt.tol = 1e-7;
    ipopt.hessian_approximation = 'limited-memory';
end

function bonmin = setup_bonmin_options
try
    bonmin = bonminset([],'noIpopt');
    bonmin = rmfield(bonmin,'var_lin');
    bonmin = rmfield(bonmin,'cons_lin');
catch
    bonmin =[];
end

function nomad = setup_nomad_options
try
    nomad = nomadset;
catch
    nomad =[];
end

function ooqp = setup_ooqp_options
try
    ooqp = ooqpset;
catch
    ooqp = [];
end

function xpress = setup_xpress_options
try
    xpress = xprsoptimset;
    cNames = recursivefieldnames(xpress);
    for i = 1:length(cNames)
        xpress = setfield(xpress,cNames{i},[]);
    end
catch
    xpress =[];
end

function qpoases = setup_qpoases_options
try
    qpoases = qpOASES_options;
catch
    qpoases =[];
end

function baron = setup_baron_options
try
    baron = baronset;
catch
    baron = [];
end

function knitro = setup_knitro_options
try
    knitro = optimset;
    knitro.optionsfile = '';
catch
    knitro.optionsfile = '';
end

function csdp = setup_csdp_options
try
    % OPTI Toolbox interface
    csdp = csdpset();
catch
    csdp.axtol  = 1e-8;
    csdp.atytol = 1e-8;
    csdp.objtol = 1e-8;
    csdp.pinftol = 1e8;
    csdp.dinftol = 1e8;
    csdp.maxiter = 100;
    csdp.minstepfrac = 0.90;
    csdp.maxstepfrac = 0.97;
    csdp.minstepp = 1e-8;
    csdp.minstepd = 1e-8;
    csdp.usexzgap = 1;
    csdp.tweakgap = 0;
end

function scip = setup_scip_options
try
    scip = optiset;
catch
    scip = [];
end

function scs = setup_scs_options
scs.alpha = 1.5;
scs.rho_x = 1e-3;
scs.max_iters = 2500;
scs.eps = 1e-3;
scs.normalize = 1;
scs.scale = 5;
scs.cg_rate = 2;
scs.eliminateequalities = 0;

function dsdp = setup_dsdp_options
try
    % OPTI Toolbox interface
    dsdp = dsdpset();
catch
    % Options for DSDP 5.6 classical interface
    dsdp.r0 = -1;
    dsdp.zbar = 0;
    dsdp.penalty  = 1e8;
    dsdp.boundy  = 1e6;
    dsdp.gaptol = 1e-7;
    dsdp.maxit  = 500;
    dsdp.steptol=5e-2;
    dsdp.inftol=1e-8;
    dsdp.dual_bound = 1e20;
    dsdp.rho = 3;
    dsdp.dynamicrho = 1;
    dsdp.bigM = 0;
    dsdp.mu0 = -1;
    dsdp.reuse = 4;
    dsdp.lp_barrier = 1;
end

function mosek = setup_mosek_options
try
    evalc('[r,res]=mosekopt(''param'');');
    mosek = res.param;
catch
    mosek.param = [];
end

function quadprog = setup_quadprog_options
try
    quadprog = trytoset('quadprog');    
    if isfield(quadprog, 'Algorithm') && ~isempty(quadprog.Algorithm)
        quadprog.Algorithm = 'active-set';
    end
    quadprog.LargeScale = 'off';
catch
    quadprog.param = [];
end

function linprog = setup_linprog_options
try
    linprog = trytoset('quadprog');
catch
    linprog.param = [];
end

function bintprog = setup_bintprog_options
try
    bintprog = trytoset('bintprog');
catch
    bintprog.param = [];
end

function fmincon = setup_fmincon_options
try
    fmincon = trytoset('fmincon');
catch
    fmincon.param = [];
end

function fminsearch = setup_fminsearch_options
try
    fminsearch = trytoset('fminsearch');
catch
    fminfminsearch.param = [];
end

function lsqnonneg = setup_lsqnonneg_options
try
    lsqnonneg = trytoset('lsqnonneg');
catch
    lsqnonneg.param = [];
end

function lsqlin = setup_lsqlin_options
try
    lsqlin = trytoset('lsqlin');
catch
    lsqlin.param = [];
end