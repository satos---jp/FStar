
open Prims

type binding =
| Binding_var of FStar_Syntax_Syntax.bv
| Binding_lid of (FStar_Ident.lident * FStar_Syntax_Syntax.tscheme)
| Binding_sig of (FStar_Ident.lident Prims.list * FStar_Syntax_Syntax.sigelt)
| Binding_univ of FStar_Syntax_Syntax.univ_name
| Binding_sig_inst of (FStar_Ident.lident Prims.list * FStar_Syntax_Syntax.sigelt * FStar_Syntax_Syntax.universes)


let is_Binding_var = (fun _discr_ -> (match (_discr_) with
| Binding_var (_) -> begin
true
end
| _ -> begin
false
end))


let is_Binding_lid = (fun _discr_ -> (match (_discr_) with
| Binding_lid (_) -> begin
true
end
| _ -> begin
false
end))


let is_Binding_sig = (fun _discr_ -> (match (_discr_) with
| Binding_sig (_) -> begin
true
end
| _ -> begin
false
end))


let is_Binding_univ = (fun _discr_ -> (match (_discr_) with
| Binding_univ (_) -> begin
true
end
| _ -> begin
false
end))


let is_Binding_sig_inst = (fun _discr_ -> (match (_discr_) with
| Binding_sig_inst (_) -> begin
true
end
| _ -> begin
false
end))


let ___Binding_var____0 = (fun projectee -> (match (projectee) with
| Binding_var (_53_16) -> begin
_53_16
end))


let ___Binding_lid____0 = (fun projectee -> (match (projectee) with
| Binding_lid (_53_19) -> begin
_53_19
end))


let ___Binding_sig____0 = (fun projectee -> (match (projectee) with
| Binding_sig (_53_22) -> begin
_53_22
end))


let ___Binding_univ____0 = (fun projectee -> (match (projectee) with
| Binding_univ (_53_25) -> begin
_53_25
end))


let ___Binding_sig_inst____0 = (fun projectee -> (match (projectee) with
| Binding_sig_inst (_53_28) -> begin
_53_28
end))


type delta_level =
| NoDelta
| Inlining
| Eager_unfolding_only
| Unfold of FStar_Syntax_Syntax.delta_depth


let is_NoDelta = (fun _discr_ -> (match (_discr_) with
| NoDelta (_) -> begin
true
end
| _ -> begin
false
end))


let is_Inlining = (fun _discr_ -> (match (_discr_) with
| Inlining (_) -> begin
true
end
| _ -> begin
false
end))


let is_Eager_unfolding_only = (fun _discr_ -> (match (_discr_) with
| Eager_unfolding_only (_) -> begin
true
end
| _ -> begin
false
end))


let is_Unfold = (fun _discr_ -> (match (_discr_) with
| Unfold (_) -> begin
true
end
| _ -> begin
false
end))


let ___Unfold____0 = (fun projectee -> (match (projectee) with
| Unfold (_53_31) -> begin
_53_31
end))


type mlift =
FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ


type edge =
{msource : FStar_Ident.lident; mtarget : FStar_Ident.lident; mlift : FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ  ->  FStar_Syntax_Syntax.typ}


let is_Mkedge : edge  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkedge"))))


type effects =
{decls : FStar_Syntax_Syntax.eff_decl Prims.list; order : edge Prims.list; joins : (FStar_Ident.lident * FStar_Ident.lident * FStar_Ident.lident * mlift * mlift) Prims.list}


let is_Mkeffects : effects  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkeffects"))))


type cached_elt =
((FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ), (FStar_Syntax_Syntax.sigelt * FStar_Syntax_Syntax.universes Prims.option)) FStar_Util.either


type env =
{solver : solver_t; range : FStar_Range.range; curmodule : FStar_Ident.lident; gamma : binding Prims.list; gamma_cache : cached_elt FStar_Util.smap; modules : FStar_Syntax_Syntax.modul Prims.list; expected_typ : FStar_Syntax_Syntax.typ Prims.option; sigtab : FStar_Syntax_Syntax.sigelt FStar_Util.smap; is_pattern : Prims.bool; instantiate_imp : Prims.bool; effects : effects; generalize : Prims.bool; letrecs : (FStar_Syntax_Syntax.lbname * FStar_Syntax_Syntax.typ) Prims.list; top_level : Prims.bool; check_uvars : Prims.bool; use_eq : Prims.bool; is_iface : Prims.bool; admit : Prims.bool; lax : Prims.bool; lax_universes : Prims.bool; type_of : env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.typ * guard_t); universe_of : env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.universe; use_bv_sorts : Prims.bool; qname_and_index : (FStar_Ident.lident * Prims.int) Prims.option} 
 and solver_t =
{init : env  ->  Prims.unit; push : Prims.string  ->  Prims.unit; pop : Prims.string  ->  Prims.unit; mark : Prims.string  ->  Prims.unit; reset_mark : Prims.string  ->  Prims.unit; commit_mark : Prims.string  ->  Prims.unit; encode_modul : env  ->  FStar_Syntax_Syntax.modul  ->  Prims.unit; encode_sig : env  ->  FStar_Syntax_Syntax.sigelt  ->  Prims.unit; solve : (Prims.unit  ->  Prims.string) Prims.option  ->  env  ->  FStar_Syntax_Syntax.typ  ->  Prims.unit; is_trivial : env  ->  FStar_Syntax_Syntax.typ  ->  Prims.bool; finish : Prims.unit  ->  Prims.unit; refresh : Prims.unit  ->  Prims.unit} 
 and guard_t =
{guard_f : FStar_TypeChecker_Common.guard_formula; deferred : FStar_TypeChecker_Common.deferred; univ_ineqs : FStar_TypeChecker_Common.univ_ineq Prims.list; implicits : (Prims.string * env * FStar_Syntax_Syntax.uvar * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.typ * FStar_Range.range) Prims.list}


let is_Mkenv : env  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkenv"))))


let is_Mksolver_t : solver_t  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mksolver_t"))))


let is_Mkguard_t : guard_t  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkguard_t"))))


type env_t =
env


type implicits =
(env * FStar_Syntax_Syntax.uvar * FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.typ * FStar_Range.range) Prims.list


type sigtable =
FStar_Syntax_Syntax.sigelt FStar_Util.smap


let should_verify : env  ->  Prims.bool = (fun env -> (((not (env.lax)) && (not (env.admit))) && (FStar_Options.should_verify env.curmodule.FStar_Ident.str)))


let visible_at : delta_level  ->  FStar_Syntax_Syntax.qualifier  ->  Prims.bool = (fun d q -> (match (((d), (q))) with
| ((NoDelta, _)) | ((Eager_unfolding_only, FStar_Syntax_Syntax.Unfold_for_unification_and_vcgen)) | ((Unfold (_), FStar_Syntax_Syntax.Unfold_for_unification_and_vcgen)) | ((Unfold (_), FStar_Syntax_Syntax.Visible_default)) -> begin
true
end
| (Inlining, FStar_Syntax_Syntax.Inline_for_extraction) -> begin
true
end
| _53_108 -> begin
false
end))


let default_table_size : Prims.int = (Prims.parse_int "200")


let new_sigtab = (fun _53_109 -> (match (()) with
| () -> begin
(FStar_Util.smap_create default_table_size)
end))


let new_gamma_cache = (fun _53_110 -> (match (()) with
| () -> begin
(FStar_Util.smap_create (Prims.parse_int "100"))
end))


let initial_env : (env  ->  FStar_Syntax_Syntax.term  ->  (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.typ * guard_t))  ->  (env  ->  FStar_Syntax_Syntax.term  ->  FStar_Syntax_Syntax.universe)  ->  solver_t  ->  FStar_Ident.lident  ->  env = (fun type_of universe_of solver module_lid -> (let _150_422 = (new_gamma_cache ())
in (let _150_421 = (new_sigtab ())
in {solver = solver; range = FStar_Range.dummyRange; curmodule = module_lid; gamma = []; gamma_cache = _150_422; modules = []; expected_typ = None; sigtab = _150_421; is_pattern = false; instantiate_imp = true; effects = {decls = []; order = []; joins = []}; generalize = true; letrecs = []; top_level = false; check_uvars = false; use_eq = false; is_iface = false; admit = false; lax = false; lax_universes = false; type_of = type_of; universe_of = universe_of; use_bv_sorts = false; qname_and_index = None})))


let sigtab : env  ->  FStar_Syntax_Syntax.sigelt FStar_Util.smap = (fun env -> env.sigtab)


let gamma_cache : env  ->  cached_elt FStar_Util.smap = (fun env -> env.gamma_cache)


type env_stack_ops =
{es_push : env  ->  env; es_mark : env  ->  env; es_reset_mark : env  ->  env; es_commit_mark : env  ->  env; es_pop : env  ->  env; es_incr_query_index : env  ->  env}


let is_Mkenv_stack_ops : env_stack_ops  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkenv_stack_ops"))))


let stack_ops : env_stack_ops = (

let query_indices = (FStar_Util.mk_ref (([])::[]))
in (

let push_query_indices = (fun _53_126 -> (match (()) with
| () -> begin
(match ((FStar_ST.read query_indices)) with
| [] -> begin
(FStar_All.failwith "Empty query indices!")
end
| _53_129 -> begin
(let _150_487 = (let _150_486 = (let _150_484 = (FStar_ST.read query_indices)
in (FStar_List.hd _150_484))
in (let _150_485 = (FStar_ST.read query_indices)
in (_150_486)::_150_485))
in (FStar_ST.op_Colon_Equals query_indices _150_487))
end)
end))
in (

let pop_query_indices = (fun _53_131 -> (match (()) with
| () -> begin
(match ((FStar_ST.read query_indices)) with
| [] -> begin
(FStar_All.failwith "Empty query indices!")
end
| (hd)::tl -> begin
(FStar_ST.op_Colon_Equals query_indices tl)
end)
end))
in (

let add_query_index = (fun _53_139 -> (match (_53_139) with
| (l, n) -> begin
(match ((FStar_ST.read query_indices)) with
| (hd)::tl -> begin
(FStar_ST.op_Colon_Equals query_indices (((((l), (n)))::hd)::tl))
end
| _53_144 -> begin
(FStar_All.failwith "Empty query indices")
end)
end))
in (

let peek_query_indices = (fun _53_146 -> (match (()) with
| () -> begin
(let _150_494 = (FStar_ST.read query_indices)
in (FStar_List.hd _150_494))
end))
in (

let commit_query_index_mark = (fun _53_148 -> (match (()) with
| () -> begin
(match ((FStar_ST.read query_indices)) with
| (hd)::(_53_151)::tl -> begin
(FStar_ST.op_Colon_Equals query_indices ((hd)::tl))
end
| _53_156 -> begin
(FStar_All.failwith "Unmarked query index stack")
end)
end))
in (

let stack = (FStar_Util.mk_ref [])
in (

let push_stack = (fun env -> (

let _53_160 = (let _150_500 = (let _150_499 = (FStar_ST.read stack)
in (env)::_150_499)
in (FStar_ST.op_Colon_Equals stack _150_500))
in (

let _53_162 = env
in (let _150_502 = (FStar_Util.smap_copy (gamma_cache env))
in (let _150_501 = (FStar_Util.smap_copy (sigtab env))
in {solver = _53_162.solver; range = _53_162.range; curmodule = _53_162.curmodule; gamma = _53_162.gamma; gamma_cache = _150_502; modules = _53_162.modules; expected_typ = _53_162.expected_typ; sigtab = _150_501; is_pattern = _53_162.is_pattern; instantiate_imp = _53_162.instantiate_imp; effects = _53_162.effects; generalize = _53_162.generalize; letrecs = _53_162.letrecs; top_level = _53_162.top_level; check_uvars = _53_162.check_uvars; use_eq = _53_162.use_eq; is_iface = _53_162.is_iface; admit = _53_162.admit; lax = _53_162.lax; lax_universes = _53_162.lax_universes; type_of = _53_162.type_of; universe_of = _53_162.universe_of; use_bv_sorts = _53_162.use_bv_sorts; qname_and_index = _53_162.qname_and_index})))))
in (

let pop_stack = (fun env -> (match ((FStar_ST.read stack)) with
| (env)::tl -> begin
(

let _53_169 = (FStar_ST.op_Colon_Equals stack tl)
in env)
end
| _53_172 -> begin
(FStar_All.failwith "Impossible: Too many pops")
end))
in (

let push = (fun env -> (

let _53_175 = (push_query_indices ())
in (push_stack env)))
in (

let pop = (fun env -> (

let _53_179 = (pop_query_indices ())
in (pop_stack env)))
in (

let mark = (fun env -> (

let _53_183 = (push_query_indices ())
in (push_stack env)))
in (

let commit_mark = (fun env -> (

let _53_187 = (commit_query_index_mark ())
in (

let _53_189 = (let _150_513 = (pop_stack env)
in (Prims.ignore _150_513))
in env)))
in (

let reset_mark = (fun env -> (

let _53_193 = (pop_query_indices ())
in (pop_stack env)))
in (

let incr_query_index = (fun env -> (

let qix = (peek_query_indices ())
in (match (env.qname_and_index) with
| None -> begin
env
end
| Some (l, n) -> begin
(match ((FStar_All.pipe_right qix (FStar_List.tryFind (fun _53_206 -> (match (_53_206) with
| (m, _53_205) -> begin
(FStar_Ident.lid_equals l m)
end))))) with
| None -> begin
(

let next = (n + (Prims.parse_int "1"))
in (

let _53_209 = (add_query_index ((l), (next)))
in (

let _53_211 = env
in {solver = _53_211.solver; range = _53_211.range; curmodule = _53_211.curmodule; gamma = _53_211.gamma; gamma_cache = _53_211.gamma_cache; modules = _53_211.modules; expected_typ = _53_211.expected_typ; sigtab = _53_211.sigtab; is_pattern = _53_211.is_pattern; instantiate_imp = _53_211.instantiate_imp; effects = _53_211.effects; generalize = _53_211.generalize; letrecs = _53_211.letrecs; top_level = _53_211.top_level; check_uvars = _53_211.check_uvars; use_eq = _53_211.use_eq; is_iface = _53_211.is_iface; admit = _53_211.admit; lax = _53_211.lax; lax_universes = _53_211.lax_universes; type_of = _53_211.type_of; universe_of = _53_211.universe_of; use_bv_sorts = _53_211.use_bv_sorts; qname_and_index = Some (((l), (next)))})))
end
| Some (_53_214, m) -> begin
(

let next = (m + (Prims.parse_int "1"))
in (

let _53_219 = (add_query_index ((l), (next)))
in (

let _53_221 = env
in {solver = _53_221.solver; range = _53_221.range; curmodule = _53_221.curmodule; gamma = _53_221.gamma; gamma_cache = _53_221.gamma_cache; modules = _53_221.modules; expected_typ = _53_221.expected_typ; sigtab = _53_221.sigtab; is_pattern = _53_221.is_pattern; instantiate_imp = _53_221.instantiate_imp; effects = _53_221.effects; generalize = _53_221.generalize; letrecs = _53_221.letrecs; top_level = _53_221.top_level; check_uvars = _53_221.check_uvars; use_eq = _53_221.use_eq; is_iface = _53_221.is_iface; admit = _53_221.admit; lax = _53_221.lax; lax_universes = _53_221.lax_universes; type_of = _53_221.type_of; universe_of = _53_221.universe_of; use_bv_sorts = _53_221.use_bv_sorts; qname_and_index = Some (((l), (next)))})))
end)
end)))
in {es_push = push; es_mark = push; es_reset_mark = pop; es_commit_mark = commit_mark; es_pop = pop; es_incr_query_index = incr_query_index})))))))))))))))


let push : env  ->  Prims.string  ->  env = (fun env msg -> (

let _53_225 = (env.solver.push msg)
in (stack_ops.es_push env)))


let mark : env  ->  env = (fun env -> (

let _53_228 = (env.solver.mark "USER MARK")
in (stack_ops.es_mark env)))


let commit_mark : env  ->  env = (fun env -> (

let _53_231 = (env.solver.commit_mark "USER MARK")
in (stack_ops.es_commit_mark env)))


let reset_mark : env  ->  env = (fun env -> (

let _53_234 = (env.solver.reset_mark "USER MARK")
in (stack_ops.es_reset_mark env)))


let pop : env  ->  Prims.string  ->  env = (fun env msg -> (

let _53_238 = (env.solver.pop msg)
in (stack_ops.es_pop env)))


let incr_query_index : env  ->  env = (fun env -> (stack_ops.es_incr_query_index env))


let debug : env  ->  FStar_Options.debug_level_t  ->  Prims.bool = (fun env l -> (FStar_Options.debug_at_level env.curmodule.FStar_Ident.str l))


let set_range : env  ->  FStar_Range.range  ->  env = (fun e r -> if (r = FStar_Range.dummyRange) then begin
e
end else begin
(

let _53_245 = e
in {solver = _53_245.solver; range = r; curmodule = _53_245.curmodule; gamma = _53_245.gamma; gamma_cache = _53_245.gamma_cache; modules = _53_245.modules; expected_typ = _53_245.expected_typ; sigtab = _53_245.sigtab; is_pattern = _53_245.is_pattern; instantiate_imp = _53_245.instantiate_imp; effects = _53_245.effects; generalize = _53_245.generalize; letrecs = _53_245.letrecs; top_level = _53_245.top_level; check_uvars = _53_245.check_uvars; use_eq = _53_245.use_eq; is_iface = _53_245.is_iface; admit = _53_245.admit; lax = _53_245.lax; lax_universes = _53_245.lax_universes; type_of = _53_245.type_of; universe_of = _53_245.universe_of; use_bv_sorts = _53_245.use_bv_sorts; qname_and_index = _53_245.qname_and_index})
end)


let get_range : env  ->  FStar_Range.range = (fun e -> e.range)


let modules : env  ->  FStar_Syntax_Syntax.modul Prims.list = (fun env -> env.modules)


let current_module : env  ->  FStar_Ident.lident = (fun env -> env.curmodule)


let set_current_module : env  ->  FStar_Ident.lident  ->  env = (fun env lid -> (

let _53_252 = env
in {solver = _53_252.solver; range = _53_252.range; curmodule = lid; gamma = _53_252.gamma; gamma_cache = _53_252.gamma_cache; modules = _53_252.modules; expected_typ = _53_252.expected_typ; sigtab = _53_252.sigtab; is_pattern = _53_252.is_pattern; instantiate_imp = _53_252.instantiate_imp; effects = _53_252.effects; generalize = _53_252.generalize; letrecs = _53_252.letrecs; top_level = _53_252.top_level; check_uvars = _53_252.check_uvars; use_eq = _53_252.use_eq; is_iface = _53_252.is_iface; admit = _53_252.admit; lax = _53_252.lax; lax_universes = _53_252.lax_universes; type_of = _53_252.type_of; universe_of = _53_252.universe_of; use_bv_sorts = _53_252.use_bv_sorts; qname_and_index = _53_252.qname_and_index}))


let has_interface : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env l -> (FStar_All.pipe_right env.modules (FStar_Util.for_some (fun m -> (m.FStar_Syntax_Syntax.is_interface && (FStar_Ident.lid_equals m.FStar_Syntax_Syntax.name l))))))


let find_in_sigtab : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.sigelt Prims.option = (fun env lid -> (FStar_Util.smap_try_find (sigtab env) (FStar_Ident.text_of_lid lid)))


let name_not_found : FStar_Ident.lid  ->  Prims.string = (fun l -> (FStar_Util.format1 "Name \"%s\" not found" l.FStar_Ident.str))


let variable_not_found : FStar_Syntax_Syntax.bv  ->  Prims.string = (fun v -> (let _150_566 = (FStar_Syntax_Print.bv_to_string v)
in (FStar_Util.format1 "Variable \"%s\" not found" _150_566)))


let new_u_univ : Prims.unit  ->  FStar_Syntax_Syntax.universe = (fun _53_261 -> (match (()) with
| () -> begin
(let _150_569 = (FStar_Unionfind.fresh None)
in FStar_Syntax_Syntax.U_unif (_150_569))
end))


let inst_tscheme_with : FStar_Syntax_Syntax.tscheme  ->  FStar_Syntax_Syntax.universes  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.term) = (fun ts us -> (match (((ts), (us))) with
| (([], t), []) -> begin
(([]), (t))
end
| ((formals, t), _53_273) -> begin
(

let _53_275 = ()
in (

let n = ((FStar_List.length formals) - (Prims.parse_int "1"))
in (

let vs = (FStar_All.pipe_right us (FStar_List.mapi (fun i u -> FStar_Syntax_Syntax.UN ((((n - i)), (u))))))
in (let _150_576 = (FStar_Syntax_Subst.subst vs t)
in ((us), (_150_576))))))
end))


let inst_tscheme : FStar_Syntax_Syntax.tscheme  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.term) = (fun _53_1 -> (match (_53_1) with
| ([], t) -> begin
(([]), (t))
end
| (us, t) -> begin
(

let us' = (FStar_All.pipe_right us (FStar_List.map (fun _53_288 -> (new_u_univ ()))))
in (inst_tscheme_with ((us), (t)) us'))
end))


let inst_tscheme_with_range : FStar_Range.range  ->  FStar_Syntax_Syntax.tscheme  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.term) = (fun r t -> (

let _53_295 = (inst_tscheme t)
in (match (_53_295) with
| (us, t) -> begin
(let _150_584 = (FStar_Syntax_Subst.set_use_range r t)
in ((us), (_150_584)))
end)))


let inst_effect_fun_with : FStar_Syntax_Syntax.universes  ->  env  ->  FStar_Syntax_Syntax.eff_decl  ->  FStar_Syntax_Syntax.tscheme  ->  FStar_Syntax_Syntax.term = (fun insts env ed _53_301 -> (match (_53_301) with
| (us, t) -> begin
(match (ed.FStar_Syntax_Syntax.binders) with
| [] -> begin
(

let univs = (FStar_List.append ed.FStar_Syntax_Syntax.univs us)
in (

let _53_304 = if ((FStar_List.length insts) <> (FStar_List.length univs)) then begin
(let _150_597 = (let _150_596 = (FStar_All.pipe_left FStar_Util.string_of_int (FStar_List.length univs))
in (let _150_595 = (FStar_All.pipe_left FStar_Util.string_of_int (FStar_List.length insts))
in (let _150_594 = (FStar_Syntax_Print.lid_to_string ed.FStar_Syntax_Syntax.mname)
in (let _150_593 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format4 "Expected %s instantiations; got %s; failed universe instantiation in effect %s\n\t%s\n" _150_596 _150_595 _150_594 _150_593)))))
in (FStar_All.failwith _150_597))
end else begin
()
end
in (let _150_598 = (inst_tscheme_with (((FStar_List.append ed.FStar_Syntax_Syntax.univs us)), (t)) insts)
in (Prims.snd _150_598))))
end
| _53_307 -> begin
(let _150_600 = (let _150_599 = (FStar_Syntax_Print.lid_to_string ed.FStar_Syntax_Syntax.mname)
in (FStar_Util.format1 "Unexpected use of an uninstantiated effect: %s\n" _150_599))
in (FStar_All.failwith _150_600))
end)
end))


type tri =
| Yes
| No
| Maybe


let is_Yes = (fun _discr_ -> (match (_discr_) with
| Yes (_) -> begin
true
end
| _ -> begin
false
end))


let is_No = (fun _discr_ -> (match (_discr_) with
| No (_) -> begin
true
end
| _ -> begin
false
end))


let is_Maybe = (fun _discr_ -> (match (_discr_) with
| Maybe (_) -> begin
true
end
| _ -> begin
false
end))


let in_cur_mod : env  ->  FStar_Ident.lident  ->  tri = (fun env l -> (

let cur = (current_module env)
in if (l.FStar_Ident.nsstr = cur.FStar_Ident.str) then begin
Yes
end else begin
if (FStar_Util.starts_with l.FStar_Ident.nsstr cur.FStar_Ident.str) then begin
(

let lns = (FStar_List.append l.FStar_Ident.ns ((l.FStar_Ident.ident)::[]))
in (

let cur = (FStar_List.append cur.FStar_Ident.ns ((cur.FStar_Ident.ident)::[]))
in (

let rec aux = (fun c l -> (match (((c), (l))) with
| ([], _53_318) -> begin
Maybe
end
| (_53_321, []) -> begin
No
end
| ((hd)::tl, (hd')::tl') when (hd.FStar_Ident.idText = hd'.FStar_Ident.idText) -> begin
(aux tl tl')
end
| _53_332 -> begin
No
end))
in (aux cur lns))))
end else begin
No
end
end))


let lookup_qname : env  ->  FStar_Ident.lident  ->  ((FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ), (FStar_Syntax_Syntax.sigelt * FStar_Syntax_Syntax.universes Prims.option)) FStar_Util.either Prims.option = (fun env lid -> (

let cur_mod = (in_cur_mod env lid)
in (

let cache = (fun t -> (

let _53_338 = (FStar_Util.smap_add (gamma_cache env) lid.FStar_Ident.str t)
in Some (t)))
in (

let found = if (cur_mod <> No) then begin
(match ((FStar_Util.smap_try_find (gamma_cache env) lid.FStar_Ident.str)) with
| None -> begin
(FStar_Util.find_map env.gamma (fun _53_2 -> (match (_53_2) with
| Binding_lid (l, t) -> begin
if (FStar_Ident.lid_equals lid l) then begin
(let _150_620 = (let _150_619 = (inst_tscheme t)
in FStar_Util.Inl (_150_619))
in Some (_150_620))
end else begin
None
end
end
| Binding_sig (_53_347, FStar_Syntax_Syntax.Sig_bundle (ses, _53_350, _53_352, _53_354)) -> begin
(FStar_Util.find_map ses (fun se -> if (FStar_All.pipe_right (FStar_Syntax_Util.lids_of_sigelt se) (FStar_Util.for_some (FStar_Ident.lid_equals lid))) then begin
(cache (FStar_Util.Inr (((se), (None)))))
end else begin
None
end))
end
| Binding_sig (lids, s) -> begin
(

let maybe_cache = (fun t -> (match (s) with
| FStar_Syntax_Syntax.Sig_declare_typ (_53_367) -> begin
Some (t)
end
| _53_370 -> begin
(cache t)
end))
in if (FStar_All.pipe_right lids (FStar_Util.for_some (FStar_Ident.lid_equals lid))) then begin
(maybe_cache (FStar_Util.Inr (((s), (None)))))
end else begin
None
end)
end
| Binding_sig_inst (lids, s, us) -> begin
if (FStar_All.pipe_right lids (FStar_Util.for_some (FStar_Ident.lid_equals lid))) then begin
Some (FStar_Util.Inr (((s), (Some (us)))))
end else begin
None
end
end
| _53_377 -> begin
None
end)))
end
| se -> begin
se
end)
end else begin
None
end
in if (FStar_Util.is_some found) then begin
found
end else begin
if ((cur_mod <> Yes) || (has_interface env env.curmodule)) then begin
(match ((find_in_sigtab env lid)) with
| Some (se) -> begin
Some (FStar_Util.Inr (((se), (None))))
end
| None -> begin
None
end)
end else begin
None
end
end))))


let rec add_sigelt : env  ->  FStar_Syntax_Syntax.sigelt  ->  Prims.unit = (fun env se -> (match (se) with
| FStar_Syntax_Syntax.Sig_bundle (ses, _53_387, _53_389, _53_391) -> begin
(add_sigelts env ses)
end
| _53_395 -> begin
(

let lids = (FStar_Syntax_Util.lids_of_sigelt se)
in (

let _53_398 = (FStar_List.iter (fun l -> (FStar_Util.smap_add (sigtab env) l.FStar_Ident.str se)) lids)
in (match (se) with
| FStar_Syntax_Syntax.Sig_new_effect (ne, _53_402) -> begin
(FStar_All.pipe_right ne.FStar_Syntax_Syntax.actions (FStar_List.iter (fun a -> (

let se_let = (FStar_Syntax_Util.action_as_lb ne.FStar_Syntax_Syntax.mname a)
in (FStar_Util.smap_add (sigtab env) a.FStar_Syntax_Syntax.action_name.FStar_Ident.str se_let)))))
end
| _53_408 -> begin
()
end)))
end))
and add_sigelts : env  ->  FStar_Syntax_Syntax.sigelt Prims.list  ->  Prims.unit = (fun env ses -> (FStar_All.pipe_right ses (FStar_List.iter (add_sigelt env))))


let try_lookup_bv : env  ->  FStar_Syntax_Syntax.bv  ->  FStar_Syntax_Syntax.term Prims.option = (fun env bv -> (FStar_Util.find_map env.gamma (fun _53_3 -> (match (_53_3) with
| Binding_var (id) when (FStar_Syntax_Syntax.bv_eq id bv) -> begin
Some (id.FStar_Syntax_Syntax.sort)
end
| _53_417 -> begin
None
end))))


let lookup_type_of_let : FStar_Syntax_Syntax.sigelt  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.term) Prims.option = (fun se lid -> (match (se) with
| FStar_Syntax_Syntax.Sig_let ((_53_421, (lb)::[]), _53_426, _53_428, _53_430, _53_432) -> begin
(let _150_643 = (inst_tscheme ((lb.FStar_Syntax_Syntax.lbunivs), (lb.FStar_Syntax_Syntax.lbtyp)))
in Some (_150_643))
end
| FStar_Syntax_Syntax.Sig_let ((_53_436, lbs), _53_440, _53_442, _53_444, _53_446) -> begin
(FStar_Util.find_map lbs (fun lb -> (match (lb.FStar_Syntax_Syntax.lbname) with
| FStar_Util.Inl (_53_451) -> begin
(FStar_All.failwith "impossible")
end
| FStar_Util.Inr (fv) -> begin
if (FStar_Syntax_Syntax.fv_eq_lid fv lid) then begin
(let _150_645 = (inst_tscheme ((lb.FStar_Syntax_Syntax.lbunivs), (lb.FStar_Syntax_Syntax.lbtyp)))
in Some (_150_645))
end else begin
None
end
end)))
end
| _53_456 -> begin
None
end))


let effect_signature : FStar_Syntax_Syntax.sigelt  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.term) Prims.option = (fun se -> (match (se) with
| FStar_Syntax_Syntax.Sig_new_effect (ne, _53_460) -> begin
(let _150_651 = (let _150_650 = (let _150_649 = (let _150_648 = (FStar_Syntax_Syntax.mk_Total ne.FStar_Syntax_Syntax.signature)
in (FStar_Syntax_Util.arrow ne.FStar_Syntax_Syntax.binders _150_648))
in ((ne.FStar_Syntax_Syntax.univs), (_150_649)))
in (inst_tscheme _150_650))
in Some (_150_651))
end
| FStar_Syntax_Syntax.Sig_effect_abbrev (lid, us, binders, _53_467, _53_469, _53_471, _53_473) -> begin
(let _150_655 = (let _150_654 = (let _150_653 = (let _150_652 = (FStar_Syntax_Syntax.mk_Total FStar_Syntax_Syntax.teff)
in (FStar_Syntax_Util.arrow binders _150_652))
in ((us), (_150_653)))
in (inst_tscheme _150_654))
in Some (_150_655))
end
| _53_477 -> begin
None
end))


let try_lookup_lid_aux : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.universes * (FStar_Syntax_Syntax.term', FStar_Syntax_Syntax.term') FStar_Syntax_Syntax.syntax) Prims.option = (fun env lid -> (

let mapper = (fun _53_4 -> (match (_53_4) with
| FStar_Util.Inl (t) -> begin
Some (t)
end
| FStar_Util.Inr (FStar_Syntax_Syntax.Sig_datacon (_53_484, uvs, t, _53_488, _53_490, _53_492, _53_494, _53_496), None) -> begin
(let _150_662 = (inst_tscheme ((uvs), (t)))
in Some (_150_662))
end
| FStar_Util.Inr (FStar_Syntax_Syntax.Sig_declare_typ (l, uvs, t, qs, _53_507), None) -> begin
if ((in_cur_mod env l) = Yes) then begin
if ((FStar_All.pipe_right qs (FStar_List.contains FStar_Syntax_Syntax.Assumption)) || env.is_iface) then begin
(let _150_663 = (inst_tscheme ((uvs), (t)))
in Some (_150_663))
end else begin
None
end
end else begin
(let _150_664 = (inst_tscheme ((uvs), (t)))
in Some (_150_664))
end
end
| FStar_Util.Inr (FStar_Syntax_Syntax.Sig_inductive_typ (lid, uvs, tps, k, _53_518, _53_520, _53_522, _53_524), None) -> begin
(match (tps) with
| [] -> begin
(let _150_666 = (inst_tscheme ((uvs), (k)))
in (FStar_All.pipe_left (fun _150_665 -> Some (_150_665)) _150_666))
end
| _53_532 -> begin
(let _150_671 = (let _150_670 = (let _150_669 = (let _150_668 = (FStar_Syntax_Syntax.mk_Total k)
in (FStar_Syntax_Util.flat_arrow tps _150_668))
in ((uvs), (_150_669)))
in (inst_tscheme _150_670))
in (FStar_All.pipe_left (fun _150_667 -> Some (_150_667)) _150_671))
end)
end
| FStar_Util.Inr (FStar_Syntax_Syntax.Sig_inductive_typ (lid, uvs, tps, k, _53_538, _53_540, _53_542, _53_544), Some (us)) -> begin
(match (tps) with
| [] -> begin
(let _150_673 = (inst_tscheme_with ((uvs), (k)) us)
in (FStar_All.pipe_left (fun _150_672 -> Some (_150_672)) _150_673))
end
| _53_553 -> begin
(let _150_678 = (let _150_677 = (let _150_676 = (let _150_675 = (FStar_Syntax_Syntax.mk_Total k)
in (FStar_Syntax_Util.flat_arrow tps _150_675))
in ((uvs), (_150_676)))
in (inst_tscheme_with _150_677 us))
in (FStar_All.pipe_left (fun _150_674 -> Some (_150_674)) _150_678))
end)
end
| FStar_Util.Inr (se) -> begin
(match (se) with
| (FStar_Syntax_Syntax.Sig_let (_53_557), None) -> begin
(lookup_type_of_let (Prims.fst se) lid)
end
| _53_562 -> begin
(effect_signature (Prims.fst se))
end)
end))
in (match ((let _150_679 = (lookup_qname env lid)
in (FStar_Util.bind_opt _150_679 mapper))) with
| Some (us, t) -> begin
Some (((us), ((

let _53_568 = t
in {FStar_Syntax_Syntax.n = _53_568.FStar_Syntax_Syntax.n; FStar_Syntax_Syntax.tk = _53_568.FStar_Syntax_Syntax.tk; FStar_Syntax_Syntax.pos = (FStar_Ident.range_of_lid lid); FStar_Syntax_Syntax.vars = _53_568.FStar_Syntax_Syntax.vars}))))
end
| None -> begin
None
end)))


let lid_exists : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env l -> (match ((lookup_qname env l)) with
| None -> begin
false
end
| Some (_53_575) -> begin
true
end))


let lookup_bv : env  ->  FStar_Syntax_Syntax.bv  ->  FStar_Syntax_Syntax.typ = (fun env bv -> (match ((try_lookup_bv env bv)) with
| None -> begin
(let _150_691 = (let _150_690 = (let _150_689 = (variable_not_found bv)
in (let _150_688 = (FStar_Syntax_Syntax.range_of_bv bv)
in ((_150_689), (_150_688))))
in FStar_Syntax_Syntax.Error (_150_690))
in (Prims.raise _150_691))
end
| Some (t) -> begin
(let _150_692 = (FStar_Syntax_Syntax.range_of_bv bv)
in (FStar_Syntax_Subst.set_use_range _150_692 t))
end))


let try_lookup_lid : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ) Prims.option = (fun env l -> (match ((try_lookup_lid_aux env l)) with
| None -> begin
None
end
| Some (us, t) -> begin
(let _150_698 = (let _150_697 = (FStar_Syntax_Subst.set_use_range (FStar_Ident.range_of_lid l) t)
in ((us), (_150_697)))
in Some (_150_698))
end))


let lookup_lid : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ) = (fun env l -> (match ((try_lookup_lid env l)) with
| None -> begin
(let _150_705 = (let _150_704 = (let _150_703 = (name_not_found l)
in ((_150_703), ((FStar_Ident.range_of_lid l))))
in FStar_Syntax_Syntax.Error (_150_704))
in (Prims.raise _150_705))
end
| Some (us, t) -> begin
((us), (t))
end))


let lookup_univ : env  ->  FStar_Syntax_Syntax.univ_name  ->  Prims.bool = (fun env x -> (FStar_All.pipe_right (FStar_List.find (fun _53_5 -> (match (_53_5) with
| Binding_univ (y) -> begin
(x.FStar_Ident.idText = y.FStar_Ident.idText)
end
| _53_602 -> begin
false
end)) env.gamma) FStar_Option.isSome))


let try_lookup_val_decl : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.tscheme * FStar_Syntax_Syntax.qualifier Prims.list) Prims.option = (fun env lid -> (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_declare_typ (_53_606, uvs, t, q, _53_611), None)) -> begin
(let _150_720 = (let _150_719 = (let _150_718 = (FStar_Syntax_Subst.set_use_range (FStar_Ident.range_of_lid lid) t)
in ((uvs), (_150_718)))
in ((_150_719), (q)))
in Some (_150_720))
end
| _53_619 -> begin
None
end))


let lookup_val_decl : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ) = (fun env lid -> (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_declare_typ (_53_623, uvs, t, _53_627, _53_629), None)) -> begin
(inst_tscheme_with_range (FStar_Ident.range_of_lid lid) ((uvs), (t)))
end
| _53_637 -> begin
(let _150_727 = (let _150_726 = (let _150_725 = (name_not_found lid)
in ((_150_725), ((FStar_Ident.range_of_lid lid))))
in FStar_Syntax_Syntax.Error (_150_726))
in (Prims.raise _150_727))
end))


let lookup_datacon : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.universes * FStar_Syntax_Syntax.typ) = (fun env lid -> (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_datacon (_53_641, uvs, t, _53_645, _53_647, _53_649, _53_651, _53_653), None)) -> begin
(inst_tscheme_with_range (FStar_Ident.range_of_lid lid) ((uvs), (t)))
end
| _53_661 -> begin
(let _150_734 = (let _150_733 = (let _150_732 = (name_not_found lid)
in ((_150_732), ((FStar_Ident.range_of_lid lid))))
in FStar_Syntax_Syntax.Error (_150_733))
in (Prims.raise _150_734))
end))


let datacons_of_typ : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident Prims.list = (fun env lid -> (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_inductive_typ (_53_665, _53_667, _53_669, _53_671, _53_673, dcs, _53_676, _53_678), _53_682)) -> begin
dcs
end
| _53_687 -> begin
[]
end))


let typ_of_datacon : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident = (fun env lid -> (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_datacon (_53_691, _53_693, _53_695, l, _53_698, _53_700, _53_702, _53_704), _53_708)) -> begin
l
end
| _53_713 -> begin
(let _150_744 = (let _150_743 = (FStar_Syntax_Print.lid_to_string lid)
in (FStar_Util.format1 "Not a datacon: %s" _150_743))
in (FStar_All.failwith _150_744))
end))


let lookup_definition : delta_level Prims.list  ->  env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.univ_names * FStar_Syntax_Syntax.term) Prims.option = (fun delta_levels env lid -> (

let visible = (fun quals -> (FStar_All.pipe_right delta_levels (FStar_Util.for_some (fun dl -> (FStar_All.pipe_right quals (FStar_Util.for_some (visible_at dl)))))))
in (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (se, None)) -> begin
(match (se) with
| FStar_Syntax_Syntax.Sig_let ((_53_726, lbs), _53_730, _53_732, quals, _53_735) when (visible quals) -> begin
(FStar_Util.find_map lbs (fun lb -> (

let fv = (FStar_Util.right lb.FStar_Syntax_Syntax.lbname)
in if (FStar_Syntax_Syntax.fv_eq_lid fv lid) then begin
(let _150_757 = (let _150_756 = (let _150_755 = (FStar_Syntax_Util.unascribe lb.FStar_Syntax_Syntax.lbdef)
in (FStar_Syntax_Subst.set_use_range (FStar_Ident.range_of_lid lid) _150_755))
in ((lb.FStar_Syntax_Syntax.lbunivs), (_150_756)))
in Some (_150_757))
end else begin
None
end)))
end
| _53_741 -> begin
None
end)
end
| _53_743 -> begin
None
end)))


let try_lookup_effect_lid : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.term Prims.option = (fun env ftv -> (match ((lookup_qname env ftv)) with
| Some (FStar_Util.Inr (se, None)) -> begin
(match ((effect_signature se)) with
| None -> begin
None
end
| Some (_53_753, t) -> begin
(let _150_762 = (FStar_Syntax_Subst.set_use_range (FStar_Ident.range_of_lid ftv) t)
in Some (_150_762))
end)
end
| _53_758 -> begin
None
end))


let lookup_effect_lid : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.term = (fun env ftv -> (match ((try_lookup_effect_lid env ftv)) with
| None -> begin
(let _150_769 = (let _150_768 = (let _150_767 = (name_not_found ftv)
in ((_150_767), ((FStar_Ident.range_of_lid ftv))))
in FStar_Syntax_Syntax.Error (_150_768))
in (Prims.raise _150_769))
end
| Some (k) -> begin
k
end))


let lookup_effect_abbrev : env  ->  FStar_Syntax_Syntax.universes  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.binders * FStar_Syntax_Syntax.comp) Prims.option = (fun env univ_insts lid0 -> (match ((lookup_qname env lid0)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_effect_abbrev (lid, univs, binders, c, quals, _53_773, _53_775), None)) -> begin
(

let lid = (let _150_776 = (FStar_Range.set_use_range (FStar_Ident.range_of_lid lid) (FStar_Ident.range_of_lid lid0))
in (FStar_Ident.set_lid_range lid _150_776))
in if (FStar_All.pipe_right quals (FStar_Util.for_some (fun _53_6 -> (match (_53_6) with
| FStar_Syntax_Syntax.Irreducible -> begin
true
end
| _53_786 -> begin
false
end)))) then begin
None
end else begin
(

let insts = if ((FStar_List.length univ_insts) = (FStar_List.length univs)) then begin
univ_insts
end else begin
if ((FStar_Ident.lid_equals lid FStar_Syntax_Const.effect_Lemma_lid) && ((FStar_List.length univ_insts) = (Prims.parse_int "1"))) then begin
(FStar_List.append univ_insts ((FStar_Syntax_Syntax.U_zero)::[]))
end else begin
(let _150_780 = (let _150_779 = (FStar_Syntax_Print.lid_to_string lid)
in (let _150_778 = (FStar_All.pipe_right (FStar_List.length univ_insts) FStar_Util.string_of_int)
in (FStar_Util.format2 "Unexpected instantiation of effect %s with %s universes" _150_779 _150_778)))
in (FStar_All.failwith _150_780))
end
end
in (match (((binders), (univs))) with
| ([], _53_790) -> begin
(FStar_All.failwith "Unexpected effect abbreviation with no arguments")
end
| (_53_793, (_53_800)::(_53_797)::_53_795) when (not ((FStar_Ident.lid_equals lid FStar_Syntax_Const.effect_Lemma_lid))) -> begin
(let _150_783 = (let _150_782 = (FStar_Syntax_Print.lid_to_string lid)
in (let _150_781 = (FStar_All.pipe_left FStar_Util.string_of_int (FStar_List.length univs))
in (FStar_Util.format2 "Unexpected effect abbreviation %s; polymorphic in %s universes" _150_782 _150_781)))
in (FStar_All.failwith _150_783))
end
| _53_804 -> begin
(

let _53_808 = (let _150_785 = (let _150_784 = (FStar_Syntax_Util.arrow binders c)
in ((univs), (_150_784)))
in (inst_tscheme_with _150_785 insts))
in (match (_53_808) with
| (_53_806, t) -> begin
(

let t = (FStar_Syntax_Subst.set_use_range (FStar_Ident.range_of_lid lid) t)
in (match ((let _150_786 = (FStar_Syntax_Subst.compress t)
in _150_786.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (binders, c) -> begin
Some (((binders), (c)))
end
| _53_815 -> begin
(FStar_All.failwith "Impossible")
end))
end))
end))
end)
end
| _53_817 -> begin
None
end))


let norm_eff_name : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident = (

let cache = (FStar_Util.smap_create (Prims.parse_int "20"))
in (fun env l -> (

let rec find = (fun l -> (match ((lookup_effect_abbrev env ((FStar_Syntax_Syntax.U_unknown)::[]) l)) with
| None -> begin
None
end
| Some (_53_825, c) -> begin
(

let l = (FStar_Syntax_Util.comp_effect_name c)
in (match ((find l)) with
| None -> begin
Some (l)
end
| Some (l') -> begin
Some (l')
end))
end))
in (

let res = (match ((FStar_Util.smap_try_find cache l.FStar_Ident.str)) with
| Some (l) -> begin
l
end
| None -> begin
(match ((find l)) with
| None -> begin
l
end
| Some (m) -> begin
(

let _53_839 = (FStar_Util.smap_add cache l.FStar_Ident.str m)
in m)
end)
end)
in (FStar_Ident.set_lid_range res (FStar_Ident.range_of_lid l))))))


let lookup_effect_quals : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.qualifier Prims.list = (fun env l -> (

let l = (norm_eff_name env l)
in (match ((lookup_qname env l)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_new_effect (ne, _53_847), _53_851)) -> begin
ne.FStar_Syntax_Syntax.qualifiers
end
| _53_856 -> begin
[]
end)))


let lookup_projector : env  ->  FStar_Ident.lident  ->  Prims.int  ->  FStar_Ident.lident = (fun env lid i -> (

let fail = (fun _53_861 -> (match (()) with
| () -> begin
(let _150_807 = (let _150_806 = (FStar_Util.string_of_int i)
in (let _150_805 = (FStar_Syntax_Print.lid_to_string lid)
in (FStar_Util.format2 "Impossible: projecting field #%s from constructor %s is undefined" _150_806 _150_805)))
in (FStar_All.failwith _150_807))
end))
in (

let _53_865 = (lookup_datacon env lid)
in (match (_53_865) with
| (_53_863, t) -> begin
(match ((let _150_808 = (FStar_Syntax_Subst.compress t)
in _150_808.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_arrow (binders, _53_868) -> begin
if ((i < (Prims.parse_int "0")) || (i >= (FStar_List.length binders))) then begin
(fail ())
end else begin
(

let b = (FStar_List.nth binders i)
in (let _150_809 = (FStar_Syntax_Util.mk_field_projector_name lid (Prims.fst b) i)
in (FStar_All.pipe_right _150_809 Prims.fst)))
end
end
| _53_873 -> begin
(fail ())
end)
end))))


let is_projector : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env l -> (match ((lookup_qname env l)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_declare_typ (_53_877, _53_879, _53_881, quals, _53_884), _53_888)) -> begin
(FStar_Util.for_some (fun _53_7 -> (match (_53_7) with
| FStar_Syntax_Syntax.Projector (_53_894) -> begin
true
end
| _53_897 -> begin
false
end)) quals)
end
| _53_899 -> begin
false
end))


let is_datacon : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_datacon (_53_903, _53_905, _53_907, _53_909, _53_911, _53_913, _53_915, _53_917), _53_921)) -> begin
true
end
| _53_926 -> begin
false
end))


let is_record : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_inductive_typ (_53_930, _53_932, _53_934, _53_936, _53_938, _53_940, tags, _53_943), _53_947)) -> begin
(FStar_Util.for_some (fun _53_8 -> (match (_53_8) with
| (FStar_Syntax_Syntax.RecordType (_)) | (FStar_Syntax_Syntax.RecordConstructor (_)) -> begin
true
end
| _53_959 -> begin
false
end)) tags)
end
| _53_961 -> begin
false
end))


let is_action : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> (match ((lookup_qname env lid)) with
| Some (FStar_Util.Inr (FStar_Syntax_Syntax.Sig_let (_53_965, _53_967, _53_969, tags, _53_972), _53_976)) -> begin
(FStar_Util.for_some (fun _53_9 -> (match (_53_9) with
| FStar_Syntax_Syntax.Action (_53_982) -> begin
true
end
| _53_985 -> begin
false
end)) tags)
end
| _53_987 -> begin
false
end))


let is_interpreted : env  ->  FStar_Syntax_Syntax.term  ->  Prims.bool = (

let interpreted_symbols = (FStar_Syntax_Const.op_Eq)::(FStar_Syntax_Const.op_notEq)::(FStar_Syntax_Const.op_LT)::(FStar_Syntax_Const.op_LTE)::(FStar_Syntax_Const.op_GT)::(FStar_Syntax_Const.op_GTE)::(FStar_Syntax_Const.op_Subtraction)::(FStar_Syntax_Const.op_Minus)::(FStar_Syntax_Const.op_Addition)::(FStar_Syntax_Const.op_Multiply)::(FStar_Syntax_Const.op_Division)::(FStar_Syntax_Const.op_Modulus)::(FStar_Syntax_Const.op_And)::(FStar_Syntax_Const.op_Or)::(FStar_Syntax_Const.op_Negation)::[]
in (fun env head -> (match ((let _150_833 = (FStar_Syntax_Util.un_uinst head)
in _150_833.FStar_Syntax_Syntax.n)) with
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
(fv.FStar_Syntax_Syntax.fv_delta = FStar_Syntax_Syntax.Delta_equational)
end
| _53_994 -> begin
false
end)))


let is_type_constructor : env  ->  FStar_Ident.lident  ->  Prims.bool = (fun env lid -> (

let mapper = (fun _53_10 -> (match (_53_10) with
| FStar_Util.Inl (_53_999) -> begin
Some (false)
end
| FStar_Util.Inr (se, _53_1003) -> begin
(match (se) with
| FStar_Syntax_Syntax.Sig_declare_typ (_53_1007, _53_1009, _53_1011, qs, _53_1014) -> begin
Some ((FStar_List.contains FStar_Syntax_Syntax.New qs))
end
| FStar_Syntax_Syntax.Sig_inductive_typ (_53_1018) -> begin
Some (true)
end
| _53_1021 -> begin
Some (false)
end)
end))
in (match ((let _150_840 = (lookup_qname env lid)
in (FStar_Util.bind_opt _150_840 mapper))) with
| Some (b) -> begin
b
end
| None -> begin
false
end)))


let effect_decl_opt : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.eff_decl Prims.option = (fun env l -> (FStar_All.pipe_right env.effects.decls (FStar_Util.find_opt (fun d -> (FStar_Ident.lid_equals d.FStar_Syntax_Syntax.mname l)))))


let get_effect_decl : env  ->  FStar_Ident.lident  ->  FStar_Syntax_Syntax.eff_decl = (fun env l -> (match ((effect_decl_opt env l)) with
| None -> begin
(let _150_852 = (let _150_851 = (let _150_850 = (name_not_found l)
in ((_150_850), ((FStar_Ident.range_of_lid l))))
in FStar_Syntax_Syntax.Error (_150_851))
in (Prims.raise _150_852))
end
| Some (md) -> begin
md
end))


let join : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident  ->  (FStar_Ident.lident * mlift * mlift) = (fun env l1 l2 -> if (FStar_Ident.lid_equals l1 l2) then begin
((l1), ((fun t wp -> wp)), ((fun t wp -> wp)))
end else begin
if (((FStar_Ident.lid_equals l1 FStar_Syntax_Const.effect_GTot_lid) && (FStar_Ident.lid_equals l2 FStar_Syntax_Const.effect_Tot_lid)) || ((FStar_Ident.lid_equals l2 FStar_Syntax_Const.effect_GTot_lid) && (FStar_Ident.lid_equals l1 FStar_Syntax_Const.effect_Tot_lid))) then begin
((FStar_Syntax_Const.effect_GTot_lid), ((fun t wp -> wp)), ((fun t wp -> wp)))
end else begin
(match ((FStar_All.pipe_right env.effects.joins (FStar_Util.find_opt (fun _53_1053 -> (match (_53_1053) with
| (m1, m2, _53_1048, _53_1050, _53_1052) -> begin
((FStar_Ident.lid_equals l1 m1) && (FStar_Ident.lid_equals l2 m2))
end))))) with
| None -> begin
(let _150_928 = (let _150_927 = (let _150_926 = (let _150_925 = (FStar_Syntax_Print.lid_to_string l1)
in (let _150_924 = (FStar_Syntax_Print.lid_to_string l2)
in (FStar_Util.format2 "Effects %s and %s cannot be composed" _150_925 _150_924)))
in ((_150_926), (env.range)))
in FStar_Syntax_Syntax.Error (_150_927))
in (Prims.raise _150_928))
end
| Some (_53_1056, _53_1058, m3, j1, j2) -> begin
((m3), (j1), (j2))
end)
end
end)


let monad_leq : env  ->  FStar_Ident.lident  ->  FStar_Ident.lident  ->  edge Prims.option = (fun env l1 l2 -> if ((FStar_Ident.lid_equals l1 l2) || ((FStar_Ident.lid_equals l1 FStar_Syntax_Const.effect_Tot_lid) && (FStar_Ident.lid_equals l2 FStar_Syntax_Const.effect_GTot_lid))) then begin
Some ({msource = l1; mtarget = l2; mlift = (fun t wp -> wp)})
end else begin
(FStar_All.pipe_right env.effects.order (FStar_Util.find_opt (fun e -> ((FStar_Ident.lid_equals l1 e.msource) && (FStar_Ident.lid_equals l2 e.mtarget)))))
end)


let wp_sig_aux : FStar_Syntax_Syntax.eff_decl Prims.list  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.term) = (fun decls m -> (match ((FStar_All.pipe_right decls (FStar_Util.find_opt (fun d -> (FStar_Ident.lid_equals d.FStar_Syntax_Syntax.mname m))))) with
| None -> begin
(let _150_943 = (FStar_Util.format1 "Impossible: declaration for monad %s not found" m.FStar_Ident.str)
in (FStar_All.failwith _150_943))
end
| Some (md) -> begin
(

let _53_1079 = (inst_tscheme ((md.FStar_Syntax_Syntax.univs), (md.FStar_Syntax_Syntax.signature)))
in (match (_53_1079) with
| (_53_1077, s) -> begin
(

let s = (FStar_Syntax_Subst.compress s)
in (match (((md.FStar_Syntax_Syntax.binders), (s.FStar_Syntax_Syntax.n))) with
| ([], FStar_Syntax_Syntax.Tm_arrow (((a, _53_1088))::((wp, _53_1084))::[], c)) when (FStar_Syntax_Syntax.is_teff (FStar_Syntax_Util.comp_result c)) -> begin
((a), (wp.FStar_Syntax_Syntax.sort))
end
| _53_1096 -> begin
(FStar_All.failwith "Impossible")
end))
end))
end))


let wp_signature : env  ->  FStar_Ident.lident  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.term) = (fun env m -> (wp_sig_aux env.effects.decls m))


let build_lattice : env  ->  FStar_Syntax_Syntax.sigelt  ->  env = (fun env se -> (match (se) with
| FStar_Syntax_Syntax.Sig_new_effect (ne, _53_1103) -> begin
(

let effects = (

let _53_1106 = env.effects
in {decls = (ne)::env.effects.decls; order = _53_1106.order; joins = _53_1106.joins})
in (

let _53_1109 = env
in {solver = _53_1109.solver; range = _53_1109.range; curmodule = _53_1109.curmodule; gamma = _53_1109.gamma; gamma_cache = _53_1109.gamma_cache; modules = _53_1109.modules; expected_typ = _53_1109.expected_typ; sigtab = _53_1109.sigtab; is_pattern = _53_1109.is_pattern; instantiate_imp = _53_1109.instantiate_imp; effects = effects; generalize = _53_1109.generalize; letrecs = _53_1109.letrecs; top_level = _53_1109.top_level; check_uvars = _53_1109.check_uvars; use_eq = _53_1109.use_eq; is_iface = _53_1109.is_iface; admit = _53_1109.admit; lax = _53_1109.lax; lax_universes = _53_1109.lax_universes; type_of = _53_1109.type_of; universe_of = _53_1109.universe_of; use_bv_sorts = _53_1109.use_bv_sorts; qname_and_index = _53_1109.qname_and_index}))
end
| FStar_Syntax_Syntax.Sig_sub_effect (sub, _53_1113) -> begin
(

let compose_edges = (fun e1 e2 -> {msource = e1.msource; mtarget = e2.mtarget; mlift = (fun r wp1 -> (let _150_958 = (e1.mlift r wp1)
in (e2.mlift r _150_958)))})
in (

let mk_lift = (fun lift_t r wp1 -> (

let _53_1128 = (inst_tscheme lift_t)
in (match (_53_1128) with
| (_53_1126, lift_t) -> begin
(let _150_970 = (let _150_969 = (let _150_968 = (let _150_967 = (FStar_Syntax_Syntax.as_arg r)
in (let _150_966 = (let _150_965 = (FStar_Syntax_Syntax.as_arg wp1)
in (_150_965)::[])
in (_150_967)::_150_966))
in ((lift_t), (_150_968)))
in FStar_Syntax_Syntax.Tm_app (_150_969))
in (FStar_Syntax_Syntax.mk _150_970 None wp1.FStar_Syntax_Syntax.pos))
end)))
in (

let sub_lift_wp = (match (sub.FStar_Syntax_Syntax.lift_wp) with
| Some (sub_lift_wp) -> begin
sub_lift_wp
end
| None -> begin
(FStar_All.failwith "sub effect should\'ve been elaborated at this stage")
end)
in (

let edge = {msource = sub.FStar_Syntax_Syntax.source; mtarget = sub.FStar_Syntax_Syntax.target; mlift = (mk_lift sub_lift_wp)}
in (

let id_edge = (fun l -> {msource = sub.FStar_Syntax_Syntax.source; mtarget = sub.FStar_Syntax_Syntax.target; mlift = (fun t wp -> wp)})
in (

let print_mlift = (fun l -> (

let arg = (let _150_987 = (FStar_Ident.lid_of_path (("ARG")::[]) FStar_Range.dummyRange)
in (FStar_Syntax_Syntax.lid_as_fv _150_987 FStar_Syntax_Syntax.Delta_constant None))
in (

let wp = (let _150_988 = (FStar_Ident.lid_of_path (("WP")::[]) FStar_Range.dummyRange)
in (FStar_Syntax_Syntax.lid_as_fv _150_988 FStar_Syntax_Syntax.Delta_constant None))
in (let _150_989 = (l arg wp)
in (FStar_Syntax_Print.term_to_string _150_989)))))
in (

let order = (edge)::env.effects.order
in (

let ms = (FStar_All.pipe_right env.effects.decls (FStar_List.map (fun e -> e.FStar_Syntax_Syntax.mname)))
in (

let find_edge = (fun order _53_1149 -> (match (_53_1149) with
| (i, j) -> begin
if (FStar_Ident.lid_equals i j) then begin
(FStar_All.pipe_right (id_edge i) (fun _150_995 -> Some (_150_995)))
end else begin
(FStar_All.pipe_right order (FStar_Util.find_opt (fun e -> ((FStar_Ident.lid_equals e.msource i) && (FStar_Ident.lid_equals e.mtarget j)))))
end
end))
in (

let order = (FStar_All.pipe_right ms (FStar_List.fold_left (fun order k -> (let _150_1003 = (FStar_All.pipe_right ms (FStar_List.collect (fun i -> if (FStar_Ident.lid_equals i k) then begin
[]
end else begin
(FStar_All.pipe_right ms (FStar_List.collect (fun j -> if (FStar_Ident.lid_equals j k) then begin
[]
end else begin
(match ((let _150_1002 = (find_edge order ((i), (k)))
in (let _150_1001 = (find_edge order ((k), (j)))
in ((_150_1002), (_150_1001))))) with
| (Some (e1), Some (e2)) -> begin
((compose_edges e1 e2))::[]
end
| _53_1161 -> begin
[]
end)
end)))
end)))
in (FStar_List.append order _150_1003))) order))
in (

let order = (FStar_Util.remove_dups (fun e1 e2 -> ((FStar_Ident.lid_equals e1.msource e2.msource) && (FStar_Ident.lid_equals e1.mtarget e2.mtarget))) order)
in (

let _53_1167 = (FStar_All.pipe_right order (FStar_List.iter (fun edge -> if ((FStar_Ident.lid_equals edge.msource FStar_Syntax_Const.effect_DIV_lid) && (let _150_1007 = (lookup_effect_quals env edge.mtarget)
in (FStar_All.pipe_right _150_1007 (FStar_List.contains FStar_Syntax_Syntax.TotalEffect)))) then begin
(let _150_1011 = (let _150_1010 = (let _150_1009 = (FStar_Util.format1 "Divergent computations cannot be included in an effect %s marked \'total\'" edge.mtarget.FStar_Ident.str)
in (let _150_1008 = (get_range env)
in ((_150_1009), (_150_1008))))
in FStar_Syntax_Syntax.Error (_150_1010))
in (Prims.raise _150_1011))
end else begin
()
end)))
in (

let joins = (FStar_All.pipe_right ms (FStar_List.collect (fun i -> (FStar_All.pipe_right ms (FStar_List.collect (fun j -> (

let join_opt = (FStar_All.pipe_right ms (FStar_List.fold_left (fun bopt k -> (match ((let _150_1101 = (find_edge order ((i), (k)))
in (let _150_1100 = (find_edge order ((j), (k)))
in ((_150_1101), (_150_1100))))) with
| (Some (ik), Some (jk)) -> begin
(match (bopt) with
| None -> begin
Some (((k), (ik), (jk)))
end
| Some (ub, _53_1181, _53_1183) -> begin
if ((let _150_1102 = (find_edge order ((k), (ub)))
in (FStar_Util.is_some _150_1102)) && (not ((let _150_1103 = (find_edge order ((ub), (k)))
in (FStar_Util.is_some _150_1103))))) then begin
Some (((k), (ik), (jk)))
end else begin
bopt
end
end)
end
| _53_1187 -> begin
bopt
end)) None))
in (match (join_opt) with
| None -> begin
[]
end
| Some (k, e1, e2) -> begin
(((i), (j), (k), (e1.mlift), (e2.mlift)))::[]
end))))))))
in (

let effects = (

let _53_1196 = env.effects
in {decls = _53_1196.decls; order = order; joins = joins})
in (

let _53_1199 = env
in {solver = _53_1199.solver; range = _53_1199.range; curmodule = _53_1199.curmodule; gamma = _53_1199.gamma; gamma_cache = _53_1199.gamma_cache; modules = _53_1199.modules; expected_typ = _53_1199.expected_typ; sigtab = _53_1199.sigtab; is_pattern = _53_1199.is_pattern; instantiate_imp = _53_1199.instantiate_imp; effects = effects; generalize = _53_1199.generalize; letrecs = _53_1199.letrecs; top_level = _53_1199.top_level; check_uvars = _53_1199.check_uvars; use_eq = _53_1199.use_eq; is_iface = _53_1199.is_iface; admit = _53_1199.admit; lax = _53_1199.lax; lax_universes = _53_1199.lax_universes; type_of = _53_1199.type_of; universe_of = _53_1199.universe_of; use_bv_sorts = _53_1199.use_bv_sorts; qname_and_index = _53_1199.qname_and_index})))))))))))))))
end
| _53_1202 -> begin
env
end))


let push_in_gamma : env  ->  binding  ->  env = (fun env s -> (

let rec push = (fun x rest -> (match (rest) with
| ((Binding_sig (_))::_) | ((Binding_sig_inst (_))::_) -> begin
(x)::rest
end
| [] -> begin
(x)::[]
end
| (local)::rest -> begin
(let _150_1152 = (push x rest)
in (local)::_150_1152)
end))
in (

let _53_1224 = env
in (let _150_1153 = (push s env.gamma)
in {solver = _53_1224.solver; range = _53_1224.range; curmodule = _53_1224.curmodule; gamma = _150_1153; gamma_cache = _53_1224.gamma_cache; modules = _53_1224.modules; expected_typ = _53_1224.expected_typ; sigtab = _53_1224.sigtab; is_pattern = _53_1224.is_pattern; instantiate_imp = _53_1224.instantiate_imp; effects = _53_1224.effects; generalize = _53_1224.generalize; letrecs = _53_1224.letrecs; top_level = _53_1224.top_level; check_uvars = _53_1224.check_uvars; use_eq = _53_1224.use_eq; is_iface = _53_1224.is_iface; admit = _53_1224.admit; lax = _53_1224.lax; lax_universes = _53_1224.lax_universes; type_of = _53_1224.type_of; universe_of = _53_1224.universe_of; use_bv_sorts = _53_1224.use_bv_sorts; qname_and_index = _53_1224.qname_and_index}))))


let push_sigelt : env  ->  FStar_Syntax_Syntax.sigelt  ->  env = (fun env s -> (

let env = (push_in_gamma env (Binding_sig ((((FStar_Syntax_Util.lids_of_sigelt s)), (s)))))
in (build_lattice env s)))


let push_sigelt_inst : env  ->  FStar_Syntax_Syntax.sigelt  ->  FStar_Syntax_Syntax.universes  ->  env = (fun env s us -> (

let env = (push_in_gamma env (Binding_sig_inst ((((FStar_Syntax_Util.lids_of_sigelt s)), (s), (us)))))
in (build_lattice env s)))


let push_local_binding : env  ->  binding  ->  env = (fun env b -> (

let _53_1235 = env
in {solver = _53_1235.solver; range = _53_1235.range; curmodule = _53_1235.curmodule; gamma = (b)::env.gamma; gamma_cache = _53_1235.gamma_cache; modules = _53_1235.modules; expected_typ = _53_1235.expected_typ; sigtab = _53_1235.sigtab; is_pattern = _53_1235.is_pattern; instantiate_imp = _53_1235.instantiate_imp; effects = _53_1235.effects; generalize = _53_1235.generalize; letrecs = _53_1235.letrecs; top_level = _53_1235.top_level; check_uvars = _53_1235.check_uvars; use_eq = _53_1235.use_eq; is_iface = _53_1235.is_iface; admit = _53_1235.admit; lax = _53_1235.lax; lax_universes = _53_1235.lax_universes; type_of = _53_1235.type_of; universe_of = _53_1235.universe_of; use_bv_sorts = _53_1235.use_bv_sorts; qname_and_index = _53_1235.qname_and_index}))


let push_bv : env  ->  FStar_Syntax_Syntax.bv  ->  env = (fun env x -> (push_local_binding env (Binding_var (x))))


let push_binders : env  ->  FStar_Syntax_Syntax.binders  ->  env = (fun env bs -> (FStar_List.fold_left (fun env _53_1245 -> (match (_53_1245) with
| (x, _53_1244) -> begin
(push_bv env x)
end)) env bs))


let binding_of_lb : FStar_Syntax_Syntax.lbname  ->  (FStar_Ident.ident Prims.list * FStar_Syntax_Syntax.term)  ->  binding = (fun x t -> (match (x) with
| FStar_Util.Inl (x) -> begin
(

let _53_1250 = ()
in (

let x = (

let _53_1252 = x
in {FStar_Syntax_Syntax.ppname = _53_1252.FStar_Syntax_Syntax.ppname; FStar_Syntax_Syntax.index = _53_1252.FStar_Syntax_Syntax.index; FStar_Syntax_Syntax.sort = (Prims.snd t)})
in Binding_var (x)))
end
| FStar_Util.Inr (fv) -> begin
Binding_lid (((fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v), (t)))
end))


let push_let_binding : env  ->  FStar_Syntax_Syntax.lbname  ->  FStar_Syntax_Syntax.tscheme  ->  env = (fun env lb ts -> (push_local_binding env (binding_of_lb lb ts)))


let push_module : env  ->  FStar_Syntax_Syntax.modul  ->  env = (fun env m -> (

let _53_1262 = (add_sigelts env m.FStar_Syntax_Syntax.exports)
in (

let _53_1264 = env
in {solver = _53_1264.solver; range = _53_1264.range; curmodule = _53_1264.curmodule; gamma = []; gamma_cache = _53_1264.gamma_cache; modules = (m)::env.modules; expected_typ = None; sigtab = _53_1264.sigtab; is_pattern = _53_1264.is_pattern; instantiate_imp = _53_1264.instantiate_imp; effects = _53_1264.effects; generalize = _53_1264.generalize; letrecs = _53_1264.letrecs; top_level = _53_1264.top_level; check_uvars = _53_1264.check_uvars; use_eq = _53_1264.use_eq; is_iface = _53_1264.is_iface; admit = _53_1264.admit; lax = _53_1264.lax; lax_universes = _53_1264.lax_universes; type_of = _53_1264.type_of; universe_of = _53_1264.universe_of; use_bv_sorts = _53_1264.use_bv_sorts; qname_and_index = _53_1264.qname_and_index})))


let push_univ_vars : env  ->  FStar_Syntax_Syntax.univ_names  ->  env = (fun env xs -> (FStar_List.fold_left (fun env x -> (push_local_binding env (Binding_univ (x)))) env xs))


let set_expected_typ : env  ->  FStar_Syntax_Syntax.typ  ->  env = (fun env t -> (

let _53_1272 = env
in {solver = _53_1272.solver; range = _53_1272.range; curmodule = _53_1272.curmodule; gamma = _53_1272.gamma; gamma_cache = _53_1272.gamma_cache; modules = _53_1272.modules; expected_typ = Some (t); sigtab = _53_1272.sigtab; is_pattern = _53_1272.is_pattern; instantiate_imp = _53_1272.instantiate_imp; effects = _53_1272.effects; generalize = _53_1272.generalize; letrecs = _53_1272.letrecs; top_level = _53_1272.top_level; check_uvars = _53_1272.check_uvars; use_eq = false; is_iface = _53_1272.is_iface; admit = _53_1272.admit; lax = _53_1272.lax; lax_universes = _53_1272.lax_universes; type_of = _53_1272.type_of; universe_of = _53_1272.universe_of; use_bv_sorts = _53_1272.use_bv_sorts; qname_and_index = _53_1272.qname_and_index}))


let expected_typ : env  ->  FStar_Syntax_Syntax.typ Prims.option = (fun env -> (match (env.expected_typ) with
| None -> begin
None
end
| Some (t) -> begin
Some (t)
end))


let clear_expected_typ : env  ->  (env * FStar_Syntax_Syntax.typ Prims.option) = (fun env -> (let _150_1206 = (expected_typ env)
in (((

let _53_1279 = env
in {solver = _53_1279.solver; range = _53_1279.range; curmodule = _53_1279.curmodule; gamma = _53_1279.gamma; gamma_cache = _53_1279.gamma_cache; modules = _53_1279.modules; expected_typ = None; sigtab = _53_1279.sigtab; is_pattern = _53_1279.is_pattern; instantiate_imp = _53_1279.instantiate_imp; effects = _53_1279.effects; generalize = _53_1279.generalize; letrecs = _53_1279.letrecs; top_level = _53_1279.top_level; check_uvars = _53_1279.check_uvars; use_eq = false; is_iface = _53_1279.is_iface; admit = _53_1279.admit; lax = _53_1279.lax; lax_universes = _53_1279.lax_universes; type_of = _53_1279.type_of; universe_of = _53_1279.universe_of; use_bv_sorts = _53_1279.use_bv_sorts; qname_and_index = _53_1279.qname_and_index})), (_150_1206))))


let finish_module : env  ->  FStar_Syntax_Syntax.modul  ->  env = (

let empty_lid = (FStar_Ident.lid_of_ids (((FStar_Ident.id_of_text ""))::[]))
in (fun env m -> (

let sigs = if (FStar_Ident.lid_equals m.FStar_Syntax_Syntax.name FStar_Syntax_Const.prims_lid) then begin
(let _150_1212 = (FStar_All.pipe_right env.gamma (FStar_List.collect (fun _53_11 -> (match (_53_11) with
| Binding_sig (_53_1286, se) -> begin
(se)::[]
end
| _53_1291 -> begin
[]
end))))
in (FStar_All.pipe_right _150_1212 FStar_List.rev))
end else begin
m.FStar_Syntax_Syntax.exports
end
in (

let _53_1293 = (add_sigelts env sigs)
in (

let _53_1295 = env
in {solver = _53_1295.solver; range = _53_1295.range; curmodule = empty_lid; gamma = []; gamma_cache = _53_1295.gamma_cache; modules = (m)::env.modules; expected_typ = _53_1295.expected_typ; sigtab = _53_1295.sigtab; is_pattern = _53_1295.is_pattern; instantiate_imp = _53_1295.instantiate_imp; effects = _53_1295.effects; generalize = _53_1295.generalize; letrecs = _53_1295.letrecs; top_level = _53_1295.top_level; check_uvars = _53_1295.check_uvars; use_eq = _53_1295.use_eq; is_iface = _53_1295.is_iface; admit = _53_1295.admit; lax = _53_1295.lax; lax_universes = _53_1295.lax_universes; type_of = _53_1295.type_of; universe_of = _53_1295.universe_of; use_bv_sorts = _53_1295.use_bv_sorts; qname_and_index = _53_1295.qname_and_index})))))


let uvars_in_env : env  ->  FStar_Syntax_Syntax.uvars = (fun env -> (

let no_uvs = (FStar_Syntax_Syntax.new_uv_set ())
in (

let ext = (fun out uvs -> (FStar_Util.set_union out uvs))
in (

let rec aux = (fun out g -> (match (g) with
| [] -> begin
out
end
| (Binding_univ (_53_1308))::tl -> begin
(aux out tl)
end
| ((Binding_lid (_, (_, t)))::tl) | ((Binding_var ({FStar_Syntax_Syntax.ppname = _; FStar_Syntax_Syntax.index = _; FStar_Syntax_Syntax.sort = t}))::tl) -> begin
(let _150_1224 = (let _150_1223 = (FStar_Syntax_Free.uvars t)
in (ext out _150_1223))
in (aux _150_1224 tl))
end
| ((Binding_sig (_))::_) | ((Binding_sig_inst (_))::_) -> begin
out
end))
in (aux no_uvs env.gamma)))))


let univ_vars : env  ->  FStar_Syntax_Syntax.universe_uvar FStar_Util.set = (fun env -> (

let no_univs = FStar_Syntax_Syntax.no_universe_uvars
in (

let ext = (fun out uvs -> (FStar_Util.set_union out uvs))
in (

let rec aux = (fun out g -> (match (g) with
| [] -> begin
out
end
| ((Binding_sig_inst (_))::tl) | ((Binding_univ (_))::tl) -> begin
(aux out tl)
end
| ((Binding_lid (_, (_, t)))::tl) | ((Binding_var ({FStar_Syntax_Syntax.ppname = _; FStar_Syntax_Syntax.index = _; FStar_Syntax_Syntax.sort = t}))::tl) -> begin
(let _150_1236 = (let _150_1235 = (FStar_Syntax_Free.univs t)
in (ext out _150_1235))
in (aux _150_1236 tl))
end
| (Binding_sig (_53_1378))::_53_1376 -> begin
out
end))
in (aux no_univs env.gamma)))))


let univnames : env  ->  FStar_Syntax_Syntax.univ_name FStar_Util.set = (fun env -> (

let no_univ_names = FStar_Syntax_Syntax.no_universe_names
in (

let ext = (fun out uvs -> (FStar_Util.set_union out uvs))
in (

let rec aux = (fun out g -> (match (g) with
| [] -> begin
out
end
| (Binding_sig_inst (_53_1392))::tl -> begin
(aux out tl)
end
| (Binding_univ (uname))::tl -> begin
(let _150_1247 = (FStar_Util.set_add uname out)
in (aux _150_1247 tl))
end
| ((Binding_lid (_, (_, t)))::tl) | ((Binding_var ({FStar_Syntax_Syntax.ppname = _; FStar_Syntax_Syntax.index = _; FStar_Syntax_Syntax.sort = t}))::tl) -> begin
(let _150_1249 = (let _150_1248 = (FStar_Syntax_Free.univnames t)
in (ext out _150_1248))
in (aux _150_1249 tl))
end
| (Binding_sig (_53_1419))::_53_1417 -> begin
out
end))
in (aux no_univ_names env.gamma)))))


let bound_vars_of_bindings : binding Prims.list  ->  FStar_Syntax_Syntax.bv Prims.list = (fun bs -> (FStar_All.pipe_right bs (FStar_List.collect (fun _53_12 -> (match (_53_12) with
| Binding_var (x) -> begin
(x)::[]
end
| (Binding_lid (_)) | (Binding_sig (_)) | (Binding_univ (_)) | (Binding_sig_inst (_)) -> begin
[]
end)))))


let binders_of_bindings : binding Prims.list  ->  FStar_Syntax_Syntax.binders = (fun bs -> (let _150_1256 = (let _150_1255 = (bound_vars_of_bindings bs)
in (FStar_All.pipe_right _150_1255 (FStar_List.map FStar_Syntax_Syntax.mk_binder)))
in (FStar_All.pipe_right _150_1256 FStar_List.rev)))


let bound_vars : env  ->  FStar_Syntax_Syntax.bv Prims.list = (fun env -> (bound_vars_of_bindings env.gamma))


let all_binders : env  ->  FStar_Syntax_Syntax.binders = (fun env -> (binders_of_bindings env.gamma))


let fold_env = (fun env f a -> (FStar_List.fold_right (fun e a -> (f a e)) env.gamma a))


let lidents : env  ->  FStar_Ident.lident Prims.list = (fun env -> (

let keys = (FStar_List.fold_left (fun keys _53_13 -> (match (_53_13) with
| Binding_sig (lids, _53_1451) -> begin
(FStar_List.append lids keys)
end
| _53_1455 -> begin
keys
end)) [] env.gamma)
in (FStar_Util.smap_fold (sigtab env) (fun _53_1457 v keys -> (FStar_List.append (FStar_Syntax_Util.lids_of_sigelt v) keys)) keys)))


let dummy_solver : solver_t = {init = (fun _53_1461 -> ()); push = (fun _53_1463 -> ()); pop = (fun _53_1465 -> ()); mark = (fun _53_1467 -> ()); reset_mark = (fun _53_1469 -> ()); commit_mark = (fun _53_1471 -> ()); encode_modul = (fun _53_1473 _53_1475 -> ()); encode_sig = (fun _53_1477 _53_1479 -> ()); solve = (fun _53_1481 _53_1483 _53_1485 -> ()); is_trivial = (fun _53_1487 _53_1489 -> false); finish = (fun _53_1491 -> ()); refresh = (fun _53_1492 -> ())}




