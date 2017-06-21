open Prims
let fail_exp lid t =
  let uu____18 =
    let uu____21 =
      let uu____22 =
        let uu____32 =
          FStar_Syntax_Syntax.fvar FStar_Syntax_Const.failwith_lid
            FStar_Syntax_Syntax.Delta_constant None
           in
        let uu____33 =
          let uu____35 = FStar_Syntax_Syntax.iarg t  in
          let uu____36 =
            let uu____38 =
              let uu____39 =
                let uu____40 =
                  let uu____43 =
                    let uu____44 =
                      let uu____45 =
                        let uu____49 =
                          let uu____50 =
                            let uu____51 =
                              FStar_Syntax_Print.lid_to_string lid  in
                            Prims.strcat "Not yet implemented:" uu____51  in
                          FStar_Bytes.string_as_unicode_bytes uu____50  in
                        (uu____49, FStar_Range.dummyRange)  in
                      FStar_Const.Const_string uu____45  in
                    FStar_Syntax_Syntax.Tm_constant uu____44  in
                  FStar_Syntax_Syntax.mk uu____43  in
                uu____40 None FStar_Range.dummyRange  in
              FStar_All.pipe_left FStar_Syntax_Syntax.as_arg uu____39  in
            [uu____38]  in
          uu____35 :: uu____36  in
        (uu____32, uu____33)  in
      FStar_Syntax_Syntax.Tm_app uu____22  in
    FStar_Syntax_Syntax.mk uu____21  in
  uu____18 None FStar_Range.dummyRange 
let mangle_projector_lid : FStar_Ident.lident -> FStar_Ident.lident =
  fun x  -> x 
let lident_as_mlsymbol : FStar_Ident.lident -> Prims.string =
  fun id  -> (id.FStar_Ident.ident).FStar_Ident.idText 
let as_pair uu___147_88 =
  match uu___147_88 with
  | a::b::[] -> (a, b)
  | uu____92 -> failwith "Expected a list with 2 elements" 
let rec extract_attr :
  FStar_Syntax_Syntax.term -> FStar_Extraction_ML_Syntax.tyattr option =
  fun x  ->
    let uu____101 = FStar_Syntax_Subst.compress x  in
    match uu____101 with
    | { FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar fv;
        FStar_Syntax_Syntax.tk = uu____104;
        FStar_Syntax_Syntax.pos = uu____105;
        FStar_Syntax_Syntax.vars = uu____106;_} when
        let uu____109 =
          let uu____110 = FStar_Syntax_Syntax.lid_of_fv fv  in
          FStar_Ident.string_of_lid uu____110  in
        uu____109 = "FStar.Pervasives.PpxDeriving" ->
        Some FStar_Extraction_ML_Syntax.PpxDeriving
    | {
        FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_app
          ({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar fv;
             FStar_Syntax_Syntax.tk = uu____112;
             FStar_Syntax_Syntax.pos = uu____113;
             FStar_Syntax_Syntax.vars = uu____114;_},({
                                                        FStar_Syntax_Syntax.n
                                                          =
                                                          FStar_Syntax_Syntax.Tm_constant
                                                          (FStar_Const.Const_string
                                                          (data,uu____116));
                                                        FStar_Syntax_Syntax.tk
                                                          = uu____117;
                                                        FStar_Syntax_Syntax.pos
                                                          = uu____118;
                                                        FStar_Syntax_Syntax.vars
                                                          = uu____119;_},uu____120)::[]);
        FStar_Syntax_Syntax.tk = uu____121;
        FStar_Syntax_Syntax.pos = uu____122;
        FStar_Syntax_Syntax.vars = uu____123;_} when
        let uu____149 =
          let uu____150 = FStar_Syntax_Syntax.lid_of_fv fv  in
          FStar_Ident.string_of_lid uu____150  in
        uu____149 = "FStar.Pervasives.PpxDerivingConstant" ->
        Some
          (FStar_Extraction_ML_Syntax.PpxDerivingConstant
             (FStar_Util.string_of_unicode data))
    | { FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_meta (x1,uu____152);
        FStar_Syntax_Syntax.tk = uu____153;
        FStar_Syntax_Syntax.pos = uu____154;
        FStar_Syntax_Syntax.vars = uu____155;_} -> extract_attr x1
    | a -> None
  
let extract_attrs :
  FStar_Syntax_Syntax.term Prims.list ->
    FStar_Extraction_ML_Syntax.tyattr Prims.list
  = fun attrs  -> FStar_List.choose extract_attr attrs 
let binders_as_mlty_binders env bs =
  FStar_Util.fold_map
    (fun env1  ->
       fun uu____201  ->
         match uu____201 with
         | (bv,uu____209) ->
             let uu____210 =
               let uu____211 =
                 let uu____213 =
                   let uu____214 = FStar_Extraction_ML_UEnv.bv_as_ml_tyvar bv
                      in
                   FStar_Extraction_ML_Syntax.MLTY_Var uu____214  in
                 Some uu____213  in
               FStar_Extraction_ML_UEnv.extend_ty env1 bv uu____211  in
             let uu____215 = FStar_Extraction_ML_UEnv.bv_as_ml_tyvar bv  in
             (uu____210, uu____215)) env bs
  
let extract_typ_abbrev :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Syntax_Syntax.fv ->
      FStar_Syntax_Syntax.qualifier Prims.list ->
        FStar_Syntax_Syntax.term Prims.list ->
          FStar_Syntax_Syntax.term ->
            (FStar_Extraction_ML_UEnv.env *
              FStar_Extraction_ML_Syntax.mlmodule1 Prims.list)
  =
  fun env  ->
    fun fv  ->
      fun quals  ->
        fun attrs  ->
          fun def  ->
            let lid = (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
               in
            let def1 =
              let uu____253 =
                let uu____254 = FStar_Syntax_Subst.compress def  in
                FStar_All.pipe_right uu____254 FStar_Syntax_Util.unmeta  in
              FStar_All.pipe_right uu____253 FStar_Syntax_Util.un_uinst  in
            let def2 =
              match def1.FStar_Syntax_Syntax.n with
              | FStar_Syntax_Syntax.Tm_abs uu____256 ->
                  FStar_Extraction_ML_Term.normalize_abs def1
              | uu____266 -> def1  in
            let uu____267 =
              match def2.FStar_Syntax_Syntax.n with
              | FStar_Syntax_Syntax.Tm_abs (bs,body,uu____274) ->
                  FStar_Syntax_Subst.open_term bs body
              | uu____287 -> ([], def2)  in
            match uu____267 with
            | (bs,body) ->
                let assumed =
                  FStar_Util.for_some
                    (fun uu___148_299  ->
                       match uu___148_299 with
                       | FStar_Syntax_Syntax.Assumption  -> true
                       | uu____300 -> false) quals
                   in
                let uu____301 = binders_as_mlty_binders env bs  in
                (match uu____301 with
                 | (env1,ml_bs) ->
                     let body1 =
                       let uu____319 =
                         FStar_Extraction_ML_Term.term_as_mlty env1 body  in
                       FStar_All.pipe_right uu____319
                         (FStar_Extraction_ML_Util.eraseTypeDeep
                            (FStar_Extraction_ML_Util.udelta_unfold env1))
                        in
                     let mangled_projector =
                       let uu____322 =
                         FStar_All.pipe_right quals
                           (FStar_Util.for_some
                              (fun uu___149_324  ->
                                 match uu___149_324 with
                                 | FStar_Syntax_Syntax.Projector uu____325 ->
                                     true
                                 | uu____328 -> false))
                          in
                       if uu____322
                       then
                         let mname = mangle_projector_lid lid  in
                         Some ((mname.FStar_Ident.ident).FStar_Ident.idText)
                       else None  in
                     let attrs1 = extract_attrs attrs  in
                     let td =
                       let uu____348 =
                         let uu____361 = lident_as_mlsymbol lid  in
                         (assumed, uu____361, mangled_projector, ml_bs,
                           attrs1,
                           (Some
                              (FStar_Extraction_ML_Syntax.MLTD_Abbrev body1)))
                          in
                       [uu____348]  in
                     let def3 =
                       let uu____394 =
                         let uu____395 =
                           FStar_Extraction_ML_Util.mlloc_of_range
                             (FStar_Ident.range_of_lid lid)
                            in
                         FStar_Extraction_ML_Syntax.MLM_Loc uu____395  in
                       [uu____394; FStar_Extraction_ML_Syntax.MLM_Ty td]  in
                     let env2 =
                       let uu____397 =
                         FStar_All.pipe_right quals
                           (FStar_Util.for_some
                              (fun uu___150_399  ->
                                 match uu___150_399 with
                                 | FStar_Syntax_Syntax.Assumption  -> true
                                 | FStar_Syntax_Syntax.New  -> true
                                 | uu____400 -> false))
                          in
                       if uu____397
                       then env1
                       else FStar_Extraction_ML_UEnv.extend_tydef env1 fv td
                        in
                     (env2, def3))
  
type data_constructor =
  {
  dname: FStar_Ident.lident ;
  dtyp: FStar_Syntax_Syntax.typ }
let __proj__Mkdata_constructor__item__dname :
  data_constructor -> FStar_Ident.lident =
  fun projectee  ->
    match projectee with
    | { dname = __fname__dname; dtyp = __fname__dtyp;_} -> __fname__dname
  
let __proj__Mkdata_constructor__item__dtyp :
  data_constructor -> FStar_Syntax_Syntax.typ =
  fun projectee  ->
    match projectee with
    | { dname = __fname__dname; dtyp = __fname__dtyp;_} -> __fname__dtyp
  
type inductive_family =
  {
  iname: FStar_Ident.lident ;
  iparams: FStar_Syntax_Syntax.binders ;
  ityp: FStar_Syntax_Syntax.term ;
  idatas: data_constructor Prims.list ;
  iquals: FStar_Syntax_Syntax.qualifier Prims.list ;
  iattrs: FStar_Extraction_ML_Syntax.tyattrs }
let __proj__Mkinductive_family__item__iname :
  inductive_family -> FStar_Ident.lident =
  fun projectee  ->
    match projectee with
    | { iname = __fname__iname; iparams = __fname__iparams;
        ityp = __fname__ityp; idatas = __fname__idatas;
        iquals = __fname__iquals; iattrs = __fname__iattrs;_} ->
        __fname__iname
  
let __proj__Mkinductive_family__item__iparams :
  inductive_family -> FStar_Syntax_Syntax.binders =
  fun projectee  ->
    match projectee with
    | { iname = __fname__iname; iparams = __fname__iparams;
        ityp = __fname__ityp; idatas = __fname__idatas;
        iquals = __fname__iquals; iattrs = __fname__iattrs;_} ->
        __fname__iparams
  
let __proj__Mkinductive_family__item__ityp :
  inductive_family -> FStar_Syntax_Syntax.term =
  fun projectee  ->
    match projectee with
    | { iname = __fname__iname; iparams = __fname__iparams;
        ityp = __fname__ityp; idatas = __fname__idatas;
        iquals = __fname__iquals; iattrs = __fname__iattrs;_} ->
        __fname__ityp
  
let __proj__Mkinductive_family__item__idatas :
  inductive_family -> data_constructor Prims.list =
  fun projectee  ->
    match projectee with
    | { iname = __fname__iname; iparams = __fname__iparams;
        ityp = __fname__ityp; idatas = __fname__idatas;
        iquals = __fname__iquals; iattrs = __fname__iattrs;_} ->
        __fname__idatas
  
let __proj__Mkinductive_family__item__iquals :
  inductive_family -> FStar_Syntax_Syntax.qualifier Prims.list =
  fun projectee  ->
    match projectee with
    | { iname = __fname__iname; iparams = __fname__iparams;
        ityp = __fname__ityp; idatas = __fname__idatas;
        iquals = __fname__iquals; iattrs = __fname__iattrs;_} ->
        __fname__iquals
  
let __proj__Mkinductive_family__item__iattrs :
  inductive_family -> FStar_Extraction_ML_Syntax.tyattrs =
  fun projectee  ->
    match projectee with
    | { iname = __fname__iname; iparams = __fname__iparams;
        ityp = __fname__ityp; idatas = __fname__idatas;
        iquals = __fname__iquals; iattrs = __fname__iattrs;_} ->
        __fname__iattrs
  
let print_ifamily : inductive_family -> Prims.unit =
  fun i  ->
    let uu____529 = FStar_Syntax_Print.lid_to_string i.iname  in
    let uu____530 = FStar_Syntax_Print.binders_to_string " " i.iparams  in
    let uu____531 = FStar_Syntax_Print.term_to_string i.ityp  in
    let uu____532 =
      let uu____533 =
        FStar_All.pipe_right i.idatas
          (FStar_List.map
             (fun d  ->
                let uu____538 = FStar_Syntax_Print.lid_to_string d.dname  in
                let uu____539 =
                  let uu____540 = FStar_Syntax_Print.term_to_string d.dtyp
                     in
                  Prims.strcat " : " uu____540  in
                Prims.strcat uu____538 uu____539))
         in
      FStar_All.pipe_right uu____533 (FStar_String.concat "\n\t\t")  in
    FStar_Util.print4 "\n\t%s %s : %s { %s }\n" uu____529 uu____530 uu____531
      uu____532
  
let bundle_as_inductive_families env ses quals attrs =
  FStar_All.pipe_right ses
    (FStar_List.collect
       (fun se  ->
          match se.FStar_Syntax_Syntax.sigel with
          | FStar_Syntax_Syntax.Sig_inductive_typ (l,_us,bs,t,_mut_i,datas)
              ->
              let uu____591 = FStar_Syntax_Subst.open_term bs t  in
              (match uu____591 with
               | (bs1,t1) ->
                   let datas1 =
                     FStar_All.pipe_right ses
                       (FStar_List.collect
                          (fun se1  ->
                             match se1.FStar_Syntax_Syntax.sigel with
                             | FStar_Syntax_Syntax.Sig_datacon
                                 (d,uu____604,t2,l',nparams,uu____608) when
                                 FStar_Ident.lid_equals l l' ->
                                 let uu____611 =
                                   FStar_Syntax_Util.arrow_formals t2  in
                                 (match uu____611 with
                                  | (bs',body) ->
                                      let uu____632 =
                                        FStar_Util.first_N
                                          (FStar_List.length bs1) bs'
                                         in
                                      (match uu____632 with
                                       | (bs_params,rest) ->
                                           let subst1 =
                                             FStar_List.map2
                                               (fun uu____670  ->
                                                  fun uu____671  ->
                                                    match (uu____670,
                                                            uu____671)
                                                    with
                                                    | ((b',uu____681),
                                                       (b,uu____683)) ->
                                                        let uu____688 =
                                                          let uu____693 =
                                                            FStar_Syntax_Syntax.bv_to_name
                                                              b
                                                             in
                                                          (b', uu____693)  in
                                                        FStar_Syntax_Syntax.NT
                                                          uu____688)
                                               bs_params bs1
                                              in
                                           let t3 =
                                             let uu____695 =
                                               let uu____698 =
                                                 FStar_Syntax_Syntax.mk_Total
                                                   body
                                                  in
                                               FStar_Syntax_Util.arrow rest
                                                 uu____698
                                                in
                                             FStar_All.pipe_right uu____695
                                               (FStar_Syntax_Subst.subst
                                                  subst1)
                                              in
                                           [{ dname = d; dtyp = t3 }]))
                             | uu____703 -> []))
                      in
                   let attrs1 =
                     extract_attrs
                       (FStar_List.append se.FStar_Syntax_Syntax.sigattrs
                          attrs)
                      in
                   [{
                      iname = l;
                      iparams = bs1;
                      ityp = t1;
                      idatas = datas1;
                      iquals = (se.FStar_Syntax_Syntax.sigquals);
                      iattrs = attrs1
                    }])
          | uu____706 -> []))
  
type env_t = FStar_Extraction_ML_UEnv.env
let extract_bundle :
  env_t ->
    FStar_Syntax_Syntax.sigelt ->
      (env_t * FStar_Extraction_ML_Syntax.mlmodule1 Prims.list)
  =
  fun env  ->
    fun se  ->
      let extract_ctor ml_tyvars env1 ctor =
        let mlt =
          let uu____749 =
            FStar_Extraction_ML_Term.term_as_mlty env1 ctor.dtyp  in
          FStar_Extraction_ML_Util.eraseTypeDeep
            (FStar_Extraction_ML_Util.udelta_unfold env1) uu____749
           in
        let steps =
          [FStar_TypeChecker_Normalize.Inlining;
          FStar_TypeChecker_Normalize.UnfoldUntil
            FStar_Syntax_Syntax.Delta_constant;
          FStar_TypeChecker_Normalize.EraseUniverses;
          FStar_TypeChecker_Normalize.AllowUnboundUniverses]  in
        let names1 =
          let uu____754 =
            let uu____755 =
              let uu____758 =
                FStar_TypeChecker_Normalize.normalize steps
                  env1.FStar_Extraction_ML_UEnv.tcenv ctor.dtyp
                 in
              FStar_Syntax_Subst.compress uu____758  in
            uu____755.FStar_Syntax_Syntax.n  in
          match uu____754 with
          | FStar_Syntax_Syntax.Tm_arrow (bs,uu____761) ->
              FStar_List.map
                (fun uu____774  ->
                   match uu____774 with
                   | ({ FStar_Syntax_Syntax.ppname = ppname;
                        FStar_Syntax_Syntax.index = uu____778;
                        FStar_Syntax_Syntax.sort = uu____779;_},uu____780)
                       -> ppname.FStar_Ident.idText) bs
          | uu____783 -> []  in
        let tys = (ml_tyvars, mlt)  in
        let fvv = FStar_Extraction_ML_UEnv.mkFvvar ctor.dname ctor.dtyp  in
        let uu____794 =
          let uu____795 =
            FStar_Extraction_ML_UEnv.extend_fv env1 fvv tys false false  in
          fst uu____795  in
        let uu____798 =
          let uu____804 = lident_as_mlsymbol ctor.dname  in
          let uu____805 =
            let uu____809 = FStar_Extraction_ML_Util.argTypes mlt  in
            FStar_List.zip names1 uu____809  in
          (uu____804, uu____805)  in
        (uu____794, uu____798)  in
      let extract_one_family env1 ind =
        let uu____839 = binders_as_mlty_binders env1 ind.iparams  in
        match uu____839 with
        | (env2,vars) ->
            let uu____866 =
              FStar_All.pipe_right ind.idatas
                (FStar_Util.fold_map (extract_ctor vars) env2)
               in
            (match uu____866 with
             | (env3,ctors) ->
                 let uu____916 = FStar_Syntax_Util.arrow_formals ind.ityp  in
                 (match uu____916 with
                  | (indices,uu____938) ->
                      let ml_params =
                        let uu____953 =
                          FStar_All.pipe_right indices
                            (FStar_List.mapi
                               (fun i  ->
                                  fun uu____968  ->
                                    let uu____971 =
                                      let uu____972 =
                                        FStar_Util.string_of_int i  in
                                      Prims.strcat "'dummyV" uu____972  in
                                    (uu____971, (Prims.parse_int "0"))))
                           in
                        FStar_List.append vars uu____953  in
                      let tbody =
                        let uu____976 =
                          FStar_Util.find_opt
                            (fun uu___151_978  ->
                               match uu___151_978 with
                               | FStar_Syntax_Syntax.RecordType uu____979 ->
                                   true
                               | uu____984 -> false) ind.iquals
                           in
                        match uu____976 with
                        | Some (FStar_Syntax_Syntax.RecordType (ns,ids)) ->
                            let uu____991 = FStar_List.hd ctors  in
                            (match uu____991 with
                             | (uu____1002,c_ty) ->
                                 let fields =
                                   FStar_List.map2
                                     (fun id  ->
                                        fun uu____1020  ->
                                          match uu____1020 with
                                          | (uu____1025,ty) ->
                                              let lid =
                                                FStar_Ident.lid_of_ids
                                                  (FStar_List.append ns [id])
                                                 in
                                              let uu____1028 =
                                                lident_as_mlsymbol lid  in
                                              (uu____1028, ty)) ids c_ty
                                    in
                                 FStar_Extraction_ML_Syntax.MLTD_Record
                                   fields)
                        | uu____1029 ->
                            FStar_Extraction_ML_Syntax.MLTD_DType ctors
                         in
                      let uu____1031 =
                        let uu____1043 = lident_as_mlsymbol ind.iname  in
                        (false, uu____1043, None, ml_params, (ind.iattrs),
                          (Some tbody))
                         in
                      (env3, uu____1031)))
         in
      match ((se.FStar_Syntax_Syntax.sigel),
              (se.FStar_Syntax_Syntax.sigquals))
      with
      | (FStar_Syntax_Syntax.Sig_bundle
         ({
            FStar_Syntax_Syntax.sigel = FStar_Syntax_Syntax.Sig_datacon
              (l,uu____1065,t,uu____1067,uu____1068,uu____1069);
            FStar_Syntax_Syntax.sigrng = uu____1070;
            FStar_Syntax_Syntax.sigquals = uu____1071;
            FStar_Syntax_Syntax.sigmeta = uu____1072;
            FStar_Syntax_Syntax.sigattrs = uu____1073;_}::[],uu____1074),(FStar_Syntax_Syntax.ExceptionConstructor
         )::[]) ->
          let uu____1083 = extract_ctor [] env { dname = l; dtyp = t }  in
          (match uu____1083 with
           | (env1,ctor) -> (env1, [FStar_Extraction_ML_Syntax.MLM_Exn ctor]))
      | (FStar_Syntax_Syntax.Sig_bundle (ses,uu____1110),quals) ->
          let ifams =
            bundle_as_inductive_families env ses quals
              se.FStar_Syntax_Syntax.sigattrs
             in
          let uu____1121 = FStar_Util.fold_map extract_one_family env ifams
             in
          (match uu____1121 with
           | (env1,td) -> (env1, [FStar_Extraction_ML_Syntax.MLM_Ty td]))
      | uu____1177 -> failwith "Unexpected signature element"
  
let rec extract_sig :
  env_t ->
    FStar_Syntax_Syntax.sigelt ->
      (env_t * FStar_Extraction_ML_Syntax.mlmodule1 Prims.list)
  =
  fun g  ->
    fun se  ->
      FStar_Extraction_ML_UEnv.debug g
        (fun u  ->
           let uu____1200 = FStar_Syntax_Print.sigelt_to_string se  in
           FStar_Util.print1 ">>>> extract_sig %s \n" uu____1200);
      (match se.FStar_Syntax_Syntax.sigel with
       | FStar_Syntax_Syntax.Sig_bundle uu____1204 -> extract_bundle g se
       | FStar_Syntax_Syntax.Sig_inductive_typ uu____1209 ->
           extract_bundle g se
       | FStar_Syntax_Syntax.Sig_datacon uu____1218 -> extract_bundle g se
       | FStar_Syntax_Syntax.Sig_new_effect ed when
           FStar_All.pipe_right se.FStar_Syntax_Syntax.sigquals
             (FStar_List.contains FStar_Syntax_Syntax.Reifiable)
           ->
           let extend_env g1 lid ml_name tm tysc =
             let uu____1246 =
               let uu____1249 =
                 FStar_Syntax_Syntax.lid_as_fv lid
                   FStar_Syntax_Syntax.Delta_equational None
                  in
               FStar_Extraction_ML_UEnv.extend_fv' g1 uu____1249 ml_name tysc
                 false false
                in
             match uu____1246 with
             | (g2,mangled_name) ->
                 ((let uu____1255 =
                     FStar_All.pipe_left
                       (FStar_TypeChecker_Env.debug
                          g2.FStar_Extraction_ML_UEnv.tcenv)
                       (FStar_Options.Other "ExtractionReify")
                      in
                   if uu____1255
                   then
                     FStar_Util.print1 "Mangled name: %s\n"
                       (fst mangled_name)
                   else ());
                  (let lb =
                     {
                       FStar_Extraction_ML_Syntax.mllb_name = mangled_name;
                       FStar_Extraction_ML_Syntax.mllb_tysc = None;
                       FStar_Extraction_ML_Syntax.mllb_add_unit = false;
                       FStar_Extraction_ML_Syntax.mllb_def = tm;
                       FStar_Extraction_ML_Syntax.print_typ = false
                     }  in
                   (g2,
                     (FStar_Extraction_ML_Syntax.MLM_Let
                        (FStar_Extraction_ML_Syntax.NonRec, [], [lb])))))
              in
           let rec extract_fv tm =
             (let uu____1267 =
                FStar_All.pipe_left
                  (FStar_TypeChecker_Env.debug
                     g.FStar_Extraction_ML_UEnv.tcenv)
                  (FStar_Options.Other "ExtractionReify")
                 in
              if uu____1267
              then
                let uu____1268 = FStar_Syntax_Print.term_to_string tm  in
                FStar_Util.print1 "extract_fv term: %s\n" uu____1268
              else ());
             (let uu____1270 =
                let uu____1271 = FStar_Syntax_Subst.compress tm  in
                uu____1271.FStar_Syntax_Syntax.n  in
              match uu____1270 with
              | FStar_Syntax_Syntax.Tm_uinst (tm1,uu____1277) ->
                  extract_fv tm1
              | FStar_Syntax_Syntax.Tm_fvar fv ->
                  let mlp =
                    FStar_Extraction_ML_Syntax.mlpath_of_lident
                      (fv.FStar_Syntax_Syntax.fv_name).FStar_Syntax_Syntax.v
                     in
                  let uu____1288 =
                    let uu____1293 = FStar_Extraction_ML_UEnv.lookup_fv g fv
                       in
                    FStar_All.pipe_left FStar_Util.right uu____1293  in
                  (match uu____1288 with
                   | (uu____1322,uu____1323,tysc,uu____1325) ->
                       let uu____1326 =
                         FStar_All.pipe_left
                           (FStar_Extraction_ML_Syntax.with_ty
                              FStar_Extraction_ML_Syntax.MLTY_Top)
                           (FStar_Extraction_ML_Syntax.MLE_Name mlp)
                          in
                       (uu____1326, tysc))
              | uu____1327 -> failwith "Not an fv")
              in
           let extract_action g1 a =
             (let uu____1349 =
                FStar_All.pipe_left
                  (FStar_TypeChecker_Env.debug
                     g1.FStar_Extraction_ML_UEnv.tcenv)
                  (FStar_Options.Other "ExtractionReify")
                 in
              if uu____1349
              then
                let uu____1350 =
                  FStar_Syntax_Print.term_to_string
                    a.FStar_Syntax_Syntax.action_typ
                   in
                let uu____1351 =
                  FStar_Syntax_Print.term_to_string
                    a.FStar_Syntax_Syntax.action_defn
                   in
                FStar_Util.print2 "Action type %s and term %s\n" uu____1350
                  uu____1351
              else ());
             (let uu____1353 = FStar_Extraction_ML_UEnv.action_name ed a  in
              match uu____1353 with
              | (a_nm,a_lid) ->
                  let lbname =
                    let uu____1363 =
                      FStar_Syntax_Syntax.new_bv
                        (Some
                           ((a.FStar_Syntax_Syntax.action_defn).FStar_Syntax_Syntax.pos))
                        FStar_Syntax_Syntax.tun
                       in
                    FStar_Util.Inl uu____1363  in
                  let lb =
                    FStar_Syntax_Syntax.mk_lb
                      (lbname, (a.FStar_Syntax_Syntax.action_univs),
                        FStar_Syntax_Const.effect_Tot_lid,
                        (a.FStar_Syntax_Syntax.action_typ),
                        (a.FStar_Syntax_Syntax.action_defn))
                     in
                  let lbs = (false, [lb])  in
                  let action_lb =
                    (FStar_Syntax_Syntax.mk
                       (FStar_Syntax_Syntax.Tm_let
                          (lbs, FStar_Syntax_Const.exp_false_bool))) None
                      (a.FStar_Syntax_Syntax.action_defn).FStar_Syntax_Syntax.pos
                     in
                  let uu____1386 =
                    FStar_Extraction_ML_Term.term_as_mlexpr g1 action_lb  in
                  (match uu____1386 with
                   | (a_let,uu____1393,ty) ->
                       ((let uu____1396 =
                           FStar_All.pipe_left
                             (FStar_TypeChecker_Env.debug
                                g1.FStar_Extraction_ML_UEnv.tcenv)
                             (FStar_Options.Other "ExtractionReify")
                            in
                         if uu____1396
                         then
                           let uu____1397 =
                             FStar_Extraction_ML_Code.string_of_mlexpr a_nm
                               a_let
                              in
                           FStar_Util.print1 "Extracted action term: %s\n"
                             uu____1397
                         else ());
                        (let uu____1399 =
                           match a_let.FStar_Extraction_ML_Syntax.expr with
                           | FStar_Extraction_ML_Syntax.MLE_Let
                               ((uu____1404,uu____1405,mllb::[]),uu____1407)
                               ->
                               (match mllb.FStar_Extraction_ML_Syntax.mllb_tysc
                                with
                                | Some tysc ->
                                    ((mllb.FStar_Extraction_ML_Syntax.mllb_def),
                                      tysc)
                                | None  -> failwith "No type scheme")
                           | uu____1418 -> failwith "Impossible"  in
                         match uu____1399 with
                         | (exp,tysc) ->
                             ((let uu____1426 =
                                 FStar_All.pipe_left
                                   (FStar_TypeChecker_Env.debug
                                      g1.FStar_Extraction_ML_UEnv.tcenv)
                                   (FStar_Options.Other "ExtractionReify")
                                  in
                               if uu____1426
                               then
                                 ((let uu____1428 =
                                     FStar_Extraction_ML_Code.string_of_mlty
                                       a_nm (snd tysc)
                                      in
                                   FStar_Util.print1
                                     "Extracted action type: %s\n" uu____1428);
                                  FStar_List.iter
                                    (fun x  ->
                                       FStar_Util.print1 "and binders: %s\n"
                                         (fst x)) (fst tysc))
                               else ());
                              extend_env g1 a_lid a_nm exp tysc)))))
              in
           let uu____1435 =
             let uu____1438 =
               extract_fv (snd ed.FStar_Syntax_Syntax.return_repr)  in
             match uu____1438 with
             | (return_tm,ty_sc) ->
                 let uu____1446 =
                   FStar_Extraction_ML_UEnv.monad_op_name ed "return"  in
                 (match uu____1446 with
                  | (return_nm,return_lid) ->
                      extend_env g return_lid return_nm return_tm ty_sc)
              in
           (match uu____1435 with
            | (g1,return_decl) ->
                let uu____1458 =
                  let uu____1461 =
                    extract_fv (snd ed.FStar_Syntax_Syntax.bind_repr)  in
                  match uu____1461 with
                  | (bind_tm,ty_sc) ->
                      let uu____1469 =
                        FStar_Extraction_ML_UEnv.monad_op_name ed "bind"  in
                      (match uu____1469 with
                       | (bind_nm,bind_lid) ->
                           extend_env g1 bind_lid bind_nm bind_tm ty_sc)
                   in
                (match uu____1458 with
                 | (g2,bind_decl) ->
                     let uu____1481 =
                       FStar_Util.fold_map extract_action g2
                         ed.FStar_Syntax_Syntax.actions
                        in
                     (match uu____1481 with
                      | (g3,actions) ->
                          (g3,
                            (FStar_List.append [return_decl; bind_decl]
                               actions)))))
       | FStar_Syntax_Syntax.Sig_new_effect uu____1493 -> (g, [])
       | FStar_Syntax_Syntax.Sig_declare_typ (lid,uu____1496,t) when
           FStar_Extraction_ML_Term.is_arity g t ->
           let quals = se.FStar_Syntax_Syntax.sigquals  in
           let attrs = se.FStar_Syntax_Syntax.sigattrs  in
           let uu____1502 =
             let uu____1503 =
               FStar_All.pipe_right quals
                 (FStar_Util.for_some
                    (fun uu___152_1505  ->
                       match uu___152_1505 with
                       | FStar_Syntax_Syntax.Assumption  -> true
                       | uu____1506 -> false))
                in
             Prims.op_Negation uu____1503  in
           if uu____1502
           then (g, [])
           else
             (let uu____1512 = FStar_Syntax_Util.arrow_formals t  in
              match uu____1512 with
              | (bs,uu____1524) ->
                  let fv =
                    FStar_Syntax_Syntax.lid_as_fv lid
                      FStar_Syntax_Syntax.Delta_constant None
                     in
                  let uu____1536 =
                    FStar_Syntax_Util.abs bs FStar_TypeChecker_Common.t_unit
                      None
                     in
                  extract_typ_abbrev g fv quals attrs uu____1536)
       | FStar_Syntax_Syntax.Sig_let ((false ,lb::[]),uu____1538) when
           FStar_Extraction_ML_Term.is_arity g lb.FStar_Syntax_Syntax.lbtyp
           ->
           let quals = se.FStar_Syntax_Syntax.sigquals  in
           let uu____1547 =
             let uu____1552 =
               FStar_TypeChecker_Env.open_universes_in
                 g.FStar_Extraction_ML_UEnv.tcenv
                 lb.FStar_Syntax_Syntax.lbunivs
                 [lb.FStar_Syntax_Syntax.lbdef; lb.FStar_Syntax_Syntax.lbtyp]
                in
             match uu____1552 with
             | (tcenv,uu____1568,def_typ) ->
                 let uu____1572 = as_pair def_typ  in (tcenv, uu____1572)
              in
           (match uu____1547 with
            | (tcenv,(lbdef,lbtyp)) ->
                let lbtyp1 =
                  FStar_TypeChecker_Normalize.unfold_whnf tcenv lbtyp  in
                let lbdef1 =
                  FStar_TypeChecker_Normalize.eta_expand_with_type tcenv
                    lbdef lbtyp1
                   in
                let uu____1587 =
                  FStar_Util.right lb.FStar_Syntax_Syntax.lbname  in
                extract_typ_abbrev g uu____1587 quals
                  se.FStar_Syntax_Syntax.sigattrs lbdef1)
       | FStar_Syntax_Syntax.Sig_let (lbs,uu____1589) ->
           let attrs = se.FStar_Syntax_Syntax.sigattrs  in
           let quals = se.FStar_Syntax_Syntax.sigquals  in
           let elet =
             FStar_Syntax_Syntax.mk
               (FStar_Syntax_Syntax.Tm_let
                  (lbs, FStar_Syntax_Const.exp_false_bool)) None
               se.FStar_Syntax_Syntax.sigrng
              in
           let tactic_registration_decl =
             let is_tactic_decl tac_lid h =
               match h.FStar_Syntax_Syntax.n with
               | FStar_Syntax_Syntax.Tm_uinst (h',uu____1613) ->
                   let uu____1618 =
                     let uu____1619 = FStar_Syntax_Subst.compress h'  in
                     uu____1619.FStar_Syntax_Syntax.n  in
                   (match uu____1618 with
                    | FStar_Syntax_Syntax.Tm_fvar fv when
                        FStar_Syntax_Syntax.fv_eq_lid fv
                          FStar_Syntax_Const.tactic_lid
                        ->
                        let uu____1623 =
                          let uu____1624 =
                            FStar_Extraction_ML_Syntax.string_of_mlpath
                              g.FStar_Extraction_ML_UEnv.currentModule
                             in
                          FStar_Util.starts_with uu____1624 "FStar.Tactics"
                           in
                        Prims.op_Negation uu____1623
                    | uu____1625 -> false)
               | uu____1626 -> false  in
             let mk_registration tac_lid assm_lid t bs =
               let h =
                 let uu____1651 =
                   let uu____1652 =
                     let uu____1653 =
                       FStar_Ident.lid_of_str
                         "FStar_Tactics_Native.register_tactic"
                        in
                     FStar_Extraction_ML_Syntax.mlpath_of_lident uu____1653
                      in
                   FStar_Extraction_ML_Syntax.MLE_Name uu____1652  in
                 FStar_All.pipe_left
                   (FStar_Extraction_ML_Syntax.with_ty
                      FStar_Extraction_ML_Syntax.MLTY_Top) uu____1651
                  in
               let lid_arg =
                 let uu____1655 =
                   let uu____1656 = FStar_Ident.string_of_lid assm_lid  in
                   FStar_Extraction_ML_Syntax.MLC_String uu____1656  in
                 FStar_Extraction_ML_Syntax.MLE_Const uu____1655  in
               let tac_arity = FStar_List.length bs  in
               let arity =
                 let uu____1663 =
                   let uu____1664 =
                     let uu____1665 =
                       FStar_Util.string_of_int
                         (tac_arity + (Prims.parse_int "1"))
                        in
                     FStar_Ident.lid_of_str uu____1665  in
                   FStar_Extraction_ML_Syntax.mlpath_of_lident uu____1664  in
                 FStar_Extraction_ML_Syntax.MLE_Name uu____1663  in
               let tac_interpretation =
                 FStar_Extraction_ML_Util.mk_interpretation_fun tac_lid
                   lid_arg t bs
                  in
               let app =
                 let uu____1674 =
                   let uu____1675 =
                     let uu____1679 =
                       FStar_List.map
                         (FStar_Extraction_ML_Syntax.with_ty
                            FStar_Extraction_ML_Syntax.MLTY_Top)
                         [lid_arg; arity; tac_interpretation]
                        in
                     (h, uu____1679)  in
                   FStar_Extraction_ML_Syntax.MLE_App uu____1675  in
                 FStar_All.pipe_left
                   (FStar_Extraction_ML_Syntax.with_ty
                      FStar_Extraction_ML_Syntax.MLTY_Top) uu____1674
                  in
               FStar_Extraction_ML_Syntax.MLM_Top app  in
             match snd lbs with
             | hd1::[] ->
                 let uu____1685 =
                   FStar_Syntax_Util.arrow_formals_comp
                     hd1.FStar_Syntax_Syntax.lbtyp
                    in
                 (match uu____1685 with
                  | (bs,comp) ->
                      let t = FStar_Syntax_Util.comp_result comp  in
                      let uu____1703 =
                        let uu____1704 = FStar_Syntax_Subst.compress t  in
                        uu____1704.FStar_Syntax_Syntax.n  in
                      (match uu____1703 with
                       | FStar_Syntax_Syntax.Tm_app (h,args) ->
                           let h1 = FStar_Syntax_Subst.compress h  in
                           let tac_lid =
                             let uu____1726 =
                               let uu____1731 =
                                 FStar_Util.right
                                   hd1.FStar_Syntax_Syntax.lbname
                                  in
                               uu____1731.FStar_Syntax_Syntax.fv_name  in
                             uu____1726.FStar_Syntax_Syntax.v  in
                           let assm_lid =
                             let uu____1736 =
                               FStar_All.pipe_left FStar_Ident.id_of_text
                                 (Prims.strcat "__"
                                    (tac_lid.FStar_Ident.ident).FStar_Ident.idText)
                                in
                             FStar_Ident.lid_of_ns_and_id
                               tac_lid.FStar_Ident.ns uu____1736
                              in
                           let uu____1737 = is_tactic_decl assm_lid h1  in
                           if uu____1737
                           then
                             let uu____1739 =
                               let uu____1740 =
                                 let uu____1743 = FStar_List.hd args  in
                                 fst uu____1743  in
                               mk_registration tac_lid assm_lid uu____1740 bs
                                in
                             [uu____1739]
                           else []
                       | uu____1755 -> []))
             | uu____1756 -> []  in
           let uu____1758 = FStar_Extraction_ML_Term.term_as_mlexpr g elet
              in
           (match uu____1758 with
            | (ml_let,uu____1766,uu____1767) ->
                (match ml_let.FStar_Extraction_ML_Syntax.expr with
                 | FStar_Extraction_ML_Syntax.MLE_Let
                     ((flavor,uu____1772,bindings),uu____1774) ->
                     let uu____1781 =
                       FStar_List.fold_left2
                         (fun uu____1788  ->
                            fun ml_lb  ->
                              fun uu____1790  ->
                                match (uu____1788, uu____1790) with
                                | ((env,ml_lbs),{
                                                  FStar_Syntax_Syntax.lbname
                                                    = lbname;
                                                  FStar_Syntax_Syntax.lbunivs
                                                    = uu____1803;
                                                  FStar_Syntax_Syntax.lbtyp =
                                                    t;
                                                  FStar_Syntax_Syntax.lbeff =
                                                    uu____1805;
                                                  FStar_Syntax_Syntax.lbdef =
                                                    uu____1806;_})
                                    ->
                                    let lb_lid =
                                      let uu____1820 =
                                        let uu____1825 =
                                          FStar_Util.right lbname  in
                                        uu____1825.FStar_Syntax_Syntax.fv_name
                                         in
                                      uu____1820.FStar_Syntax_Syntax.v  in
                                    let uu____1829 =
                                      let uu____1832 =
                                        FStar_All.pipe_right quals
                                          (FStar_Util.for_some
                                             (fun uu___153_1834  ->
                                                match uu___153_1834 with
                                                | FStar_Syntax_Syntax.Projector
                                                    uu____1835 -> true
                                                | uu____1838 -> false))
                                         in
                                      if uu____1832
                                      then
                                        let mname =
                                          let uu____1842 =
                                            mangle_projector_lid lb_lid  in
                                          FStar_All.pipe_right uu____1842
                                            FStar_Extraction_ML_Syntax.mlpath_of_lident
                                           in
                                        let uu____1843 =
                                          let uu____1846 =
                                            FStar_Util.right lbname  in
                                          let uu____1847 =
                                            FStar_Util.must
                                              ml_lb.FStar_Extraction_ML_Syntax.mllb_tysc
                                             in
                                          FStar_Extraction_ML_UEnv.extend_fv'
                                            env uu____1846 mname uu____1847
                                            ml_lb.FStar_Extraction_ML_Syntax.mllb_add_unit
                                            false
                                           in
                                        match uu____1843 with
                                        | (env1,uu____1851) ->
                                            (env1,
                                              (let uu___158_1852 = ml_lb  in
                                               {
                                                 FStar_Extraction_ML_Syntax.mllb_name
                                                   =
                                                   ((snd mname),
                                                     (Prims.parse_int "0"));
                                                 FStar_Extraction_ML_Syntax.mllb_tysc
                                                   =
                                                   (uu___158_1852.FStar_Extraction_ML_Syntax.mllb_tysc);
                                                 FStar_Extraction_ML_Syntax.mllb_add_unit
                                                   =
                                                   (uu___158_1852.FStar_Extraction_ML_Syntax.mllb_add_unit);
                                                 FStar_Extraction_ML_Syntax.mllb_def
                                                   =
                                                   (uu___158_1852.FStar_Extraction_ML_Syntax.mllb_def);
                                                 FStar_Extraction_ML_Syntax.print_typ
                                                   =
                                                   (uu___158_1852.FStar_Extraction_ML_Syntax.print_typ)
                                               }))
                                      else
                                        (let uu____1855 =
                                           let uu____1856 =
                                             let uu____1859 =
                                               FStar_Util.must
                                                 ml_lb.FStar_Extraction_ML_Syntax.mllb_tysc
                                                in
                                             FStar_Extraction_ML_UEnv.extend_lb
                                               env lbname t uu____1859
                                               ml_lb.FStar_Extraction_ML_Syntax.mllb_add_unit
                                               false
                                              in
                                           FStar_All.pipe_left
                                             FStar_Pervasives.fst uu____1856
                                            in
                                         (uu____1855, ml_lb))
                                       in
                                    (match uu____1829 with
                                     | (g1,ml_lb1) ->
                                         (g1, (ml_lb1 :: ml_lbs)))) (g, [])
                         bindings (snd lbs)
                        in
                     (match uu____1781 with
                      | (g1,ml_lbs') ->
                          let flags =
                            FStar_List.choose
                              (fun uu___154_1879  ->
                                 match uu___154_1879 with
                                 | FStar_Syntax_Syntax.Assumption  ->
                                     Some FStar_Extraction_ML_Syntax.Assumed
                                 | FStar_Syntax_Syntax.Private  ->
                                     Some FStar_Extraction_ML_Syntax.Private
                                 | FStar_Syntax_Syntax.NoExtract  ->
                                     Some
                                       FStar_Extraction_ML_Syntax.NoExtract
                                 | uu____1881 -> None) quals
                             in
                          let flags' =
                            FStar_List.choose
                              (fun uu___155_1886  ->
                                 match uu___155_1886 with
                                 | {
                                     FStar_Syntax_Syntax.n =
                                       FStar_Syntax_Syntax.Tm_constant
                                       (FStar_Const.Const_string
                                       (data,uu____1891));
                                     FStar_Syntax_Syntax.tk = uu____1892;
                                     FStar_Syntax_Syntax.pos = uu____1893;
                                     FStar_Syntax_Syntax.vars = uu____1894;_}
                                     ->
                                     Some
                                       (FStar_Extraction_ML_Syntax.Attribute
                                          (FStar_Util.string_of_unicode data))
                                 | uu____1899 ->
                                     (FStar_Util.print_warning
                                        "Warning: unrecognized, non-string attribute, bother protz for a better error message";
                                      None)) attrs
                             in
                          let uu____1903 =
                            let uu____1905 =
                              let uu____1907 =
                                let uu____1908 =
                                  FStar_Extraction_ML_Util.mlloc_of_range
                                    se.FStar_Syntax_Syntax.sigrng
                                   in
                                FStar_Extraction_ML_Syntax.MLM_Loc uu____1908
                                 in
                              [uu____1907;
                              FStar_Extraction_ML_Syntax.MLM_Let
                                (flavor, (FStar_List.append flags flags'),
                                  (FStar_List.rev ml_lbs'))]
                               in
                            FStar_List.append uu____1905
                              tactic_registration_decl
                             in
                          (g1, uu____1903))
                 | uu____1912 ->
                     let uu____1913 =
                       let uu____1914 =
                         FStar_Extraction_ML_Code.string_of_mlexpr
                           g.FStar_Extraction_ML_UEnv.currentModule ml_let
                          in
                       FStar_Util.format1
                         "Impossible: Translated a let to a non-let: %s"
                         uu____1914
                        in
                     failwith uu____1913))
       | FStar_Syntax_Syntax.Sig_declare_typ (lid,uu____1919,t) ->
           let quals = se.FStar_Syntax_Syntax.sigquals  in
           let uu____1923 =
             FStar_All.pipe_right quals
               (FStar_List.contains FStar_Syntax_Syntax.Assumption)
              in
           if uu____1923
           then
             let always_fail =
               let imp =
                 let uu____1930 = FStar_Syntax_Util.arrow_formals t  in
                 match uu____1930 with
                 | ([],t1) ->
                     let b =
                       let uu____1949 =
                         FStar_Syntax_Syntax.gen_bv "_" None t1  in
                       FStar_All.pipe_left FStar_Syntax_Syntax.mk_binder
                         uu____1949
                        in
                     let uu____1950 = fail_exp lid t1  in
                     FStar_Syntax_Util.abs [b] uu____1950 None
                 | (bs,t1) ->
                     let uu____1963 = fail_exp lid t1  in
                     FStar_Syntax_Util.abs bs uu____1963 None
                  in
               let uu___159_1964 = se  in
               let uu____1965 =
                 let uu____1966 =
                   let uu____1970 =
                     let uu____1974 =
                       let uu____1976 =
                         let uu____1977 =
                           let uu____1980 =
                             FStar_Syntax_Syntax.lid_as_fv lid
                               FStar_Syntax_Syntax.Delta_constant None
                              in
                           FStar_Util.Inr uu____1980  in
                         {
                           FStar_Syntax_Syntax.lbname = uu____1977;
                           FStar_Syntax_Syntax.lbunivs = [];
                           FStar_Syntax_Syntax.lbtyp = t;
                           FStar_Syntax_Syntax.lbeff =
                             FStar_Syntax_Const.effect_ML_lid;
                           FStar_Syntax_Syntax.lbdef = imp
                         }  in
                       [uu____1976]  in
                     (false, uu____1974)  in
                   (uu____1970, [])  in
                 FStar_Syntax_Syntax.Sig_let uu____1966  in
               {
                 FStar_Syntax_Syntax.sigel = uu____1965;
                 FStar_Syntax_Syntax.sigrng =
                   (uu___159_1964.FStar_Syntax_Syntax.sigrng);
                 FStar_Syntax_Syntax.sigquals =
                   (uu___159_1964.FStar_Syntax_Syntax.sigquals);
                 FStar_Syntax_Syntax.sigmeta =
                   (uu___159_1964.FStar_Syntax_Syntax.sigmeta);
                 FStar_Syntax_Syntax.sigattrs =
                   (uu___159_1964.FStar_Syntax_Syntax.sigattrs)
               }  in
             let uu____1986 = extract_sig g always_fail  in
             (match uu____1986 with
              | (g1,mlm) ->
                  let uu____1997 =
                    FStar_Util.find_map quals
                      (fun uu___156_1999  ->
                         match uu___156_1999 with
                         | FStar_Syntax_Syntax.Discriminator l -> Some l
                         | uu____2002 -> None)
                     in
                  (match uu____1997 with
                   | Some l ->
                       let uu____2007 =
                         let uu____2009 =
                           let uu____2010 =
                             FStar_Extraction_ML_Util.mlloc_of_range
                               se.FStar_Syntax_Syntax.sigrng
                              in
                           FStar_Extraction_ML_Syntax.MLM_Loc uu____2010  in
                         let uu____2011 =
                           let uu____2013 =
                             FStar_Extraction_ML_Term.ind_discriminator_body
                               g1 lid l
                              in
                           [uu____2013]  in
                         uu____2009 :: uu____2011  in
                       (g1, uu____2007)
                   | uu____2015 ->
                       let uu____2017 =
                         FStar_Util.find_map quals
                           (fun uu___157_2019  ->
                              match uu___157_2019 with
                              | FStar_Syntax_Syntax.Projector (l,uu____2022)
                                  -> Some l
                              | uu____2023 -> None)
                          in
                       (match uu____2017 with
                        | Some uu____2027 -> (g1, [])
                        | uu____2029 -> (g1, mlm))))
           else (g, [])
       | FStar_Syntax_Syntax.Sig_main e ->
           let uu____2035 = FStar_Extraction_ML_Term.term_as_mlexpr g e  in
           (match uu____2035 with
            | (ml_main,uu____2043,uu____2044) ->
                let uu____2045 =
                  let uu____2047 =
                    let uu____2048 =
                      FStar_Extraction_ML_Util.mlloc_of_range
                        se.FStar_Syntax_Syntax.sigrng
                       in
                    FStar_Extraction_ML_Syntax.MLM_Loc uu____2048  in
                  [uu____2047; FStar_Extraction_ML_Syntax.MLM_Top ml_main]
                   in
                (g, uu____2045))
       | FStar_Syntax_Syntax.Sig_new_effect_for_free uu____2050 ->
           failwith "impossible -- removed by tc.fs"
       | FStar_Syntax_Syntax.Sig_assume uu____2054 -> (g, [])
       | FStar_Syntax_Syntax.Sig_sub_effect uu____2058 -> (g, [])
       | FStar_Syntax_Syntax.Sig_effect_abbrev uu____2060 -> (g, [])
       | FStar_Syntax_Syntax.Sig_pragma p ->
           (if p = FStar_Syntax_Syntax.LightOff
            then FStar_Options.set_ml_ish ()
            else ();
            (g, [])))
  
let extract_iface :
  FStar_Extraction_ML_UEnv.env -> FStar_Syntax_Syntax.modul -> env_t =
  fun g  ->
    fun m  ->
      let uu____2080 =
        FStar_Util.fold_map extract_sig g m.FStar_Syntax_Syntax.declarations
         in
      FStar_All.pipe_right uu____2080 FStar_Pervasives.fst
  
let extract :
  FStar_Extraction_ML_UEnv.env ->
    FStar_Syntax_Syntax.modul ->
      (FStar_Extraction_ML_UEnv.env * FStar_Extraction_ML_Syntax.mllib
        Prims.list)
  =
  fun g  ->
    fun m  ->
      FStar_Syntax_Syntax.reset_gensym ();
      (let uu____2108 = FStar_Options.debug_any ()  in
       if uu____2108
       then
         let uu____2109 =
           FStar_Syntax_Print.lid_to_string m.FStar_Syntax_Syntax.name  in
         FStar_Util.print1 "Extracting module %s\n" uu____2109
       else ());
      (let uu____2111 = FStar_Options.restore_cmd_line_options true  in
       let name =
         FStar_Extraction_ML_Syntax.mlpath_of_lident
           m.FStar_Syntax_Syntax.name
          in
       let g1 =
         let uu___160_2114 = g  in
         {
           FStar_Extraction_ML_UEnv.tcenv =
             (uu___160_2114.FStar_Extraction_ML_UEnv.tcenv);
           FStar_Extraction_ML_UEnv.gamma =
             (uu___160_2114.FStar_Extraction_ML_UEnv.gamma);
           FStar_Extraction_ML_UEnv.tydefs =
             (uu___160_2114.FStar_Extraction_ML_UEnv.tydefs);
           FStar_Extraction_ML_UEnv.currentModule = name
         }  in
       let uu____2115 =
         FStar_Util.fold_map extract_sig g1
           m.FStar_Syntax_Syntax.declarations
          in
       match uu____2115 with
       | (g2,sigs) ->
           let mlm = FStar_List.flatten sigs  in
           let is_kremlin =
             let uu____2132 = FStar_Options.codegen ()  in
             match uu____2132 with
             | Some "Kremlin" -> true
             | uu____2134 -> false  in
           let uu____2136 =
             (((m.FStar_Syntax_Syntax.name).FStar_Ident.str <> "Prims") &&
                (is_kremlin ||
                   (Prims.op_Negation m.FStar_Syntax_Syntax.is_interface)))
               &&
               (FStar_Options.should_extract
                  (m.FStar_Syntax_Syntax.name).FStar_Ident.str)
              in
           if uu____2136
           then
             ((let uu____2141 =
                 FStar_Syntax_Print.lid_to_string m.FStar_Syntax_Syntax.name
                  in
               FStar_Util.print1 "Extracted module %s\n" uu____2141);
              (g2,
                [FStar_Extraction_ML_Syntax.MLLib
                   [(name, (Some ([], mlm)),
                      (FStar_Extraction_ML_Syntax.MLLib []))]]))
           else (g2, []))
  