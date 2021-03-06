open Prims
type ident = {
  idText: Prims.string ;
  idRange: FStar_Range.range }[@@deriving yojson,show]
let (__proj__Mkident__item__idText : ident -> Prims.string) =
  fun projectee -> match projectee with | { idText; idRange;_} -> idText
let (__proj__Mkident__item__idRange : ident -> FStar_Range.range) =
  fun projectee -> match projectee with | { idText; idRange;_} -> idRange
type path = Prims.string Prims.list[@@deriving yojson,show]
type ipath = ident Prims.list[@@deriving yojson,show]
type lident =
  {
  ns: ipath ;
  ident: ident ;
  nsstr: Prims.string ;
  str: Prims.string }[@@deriving yojson,show]
let (__proj__Mklident__item__ns : lident -> ipath) =
  fun projectee ->
    match projectee with | { ns; ident = ident1; nsstr; str;_} -> ns
let (__proj__Mklident__item__ident : lident -> ident) =
  fun projectee ->
    match projectee with | { ns; ident = ident1; nsstr; str;_} -> ident1
let (__proj__Mklident__item__nsstr : lident -> Prims.string) =
  fun projectee ->
    match projectee with | { ns; ident = ident1; nsstr; str;_} -> nsstr
let (__proj__Mklident__item__str : lident -> Prims.string) =
  fun projectee ->
    match projectee with | { ns; ident = ident1; nsstr; str;_} -> str
type lid = lident[@@deriving yojson,show]
let (mk_ident : (Prims.string * FStar_Range.range) -> ident) =
  fun uu____98 ->
    match uu____98 with | (text, range) -> { idText = text; idRange = range }
let (set_id_range : FStar_Range.range -> ident -> ident) =
  fun r ->
    fun i ->
      let uu___23_115 = i in { idText = (uu___23_115.idText); idRange = r }
let (reserved_prefix : Prims.string) = "uu___"
let (_gen : ((unit -> Prims.int) * (unit -> unit))) =
  let x = FStar_Util.mk_ref Prims.int_zero in
  let next_id uu____134 =
    let v = FStar_ST.read x in FStar_ST.write x (v + Prims.int_one); v in
  let reset uu____154 = FStar_ST.write x Prims.int_zero in (next_id, reset)
let (next_id : unit -> Prims.int) =
  fun uu____171 -> FStar_Pervasives_Native.fst _gen ()
let (reset_gensym : unit -> unit) =
  fun uu____182 -> FStar_Pervasives_Native.snd _gen ()
let (gen' : Prims.string -> FStar_Range.range -> ident) =
  fun s ->
    fun r ->
      let i = next_id () in
      mk_ident ((Prims.op_Hat s (Prims.string_of_int i)), r)
let (gen : FStar_Range.range -> ident) = fun r -> gen' reserved_prefix r
let (ident_of_lid : lident -> ident) = fun l -> l.ident
let (range_of_id : ident -> FStar_Range.range) = fun id -> id.idRange
let (id_of_text : Prims.string -> ident) =
  fun str -> mk_ident (str, FStar_Range.dummyRange)
let (string_of_id : ident -> Prims.string) = fun id -> id.idText
let (text_of_path : path -> Prims.string) =
  fun path1 -> FStar_Util.concat_l "." path1
let (path_of_text : Prims.string -> path) =
  fun text -> FStar_String.split [46] text
let (path_of_ns : ipath -> path) = fun ns -> FStar_List.map string_of_id ns
let (path_of_lid : lident -> path) =
  fun lid1 ->
    FStar_List.map string_of_id (FStar_List.append lid1.ns [lid1.ident])
let (ns_of_lid : lident -> ipath) = fun lid1 -> lid1.ns
let (ids_of_lid : lident -> ipath) =
  fun lid1 -> FStar_List.append lid1.ns [lid1.ident]
let (lid_of_ns_and_id : ipath -> ident -> lident) =
  fun ns ->
    fun id ->
      let nsstr =
        let uu____266 = FStar_List.map string_of_id ns in
        FStar_All.pipe_right uu____266 text_of_path in
      {
        ns;
        ident = id;
        nsstr;
        str =
          (if nsstr = ""
           then id.idText
           else Prims.op_Hat nsstr (Prims.op_Hat "." id.idText))
      }
let (lid_of_ids : ipath -> lident) =
  fun ids ->
    let uu____273 = FStar_Util.prefix ids in
    match uu____273 with | (ns, id) -> lid_of_ns_and_id ns id
let (lid_of_str : Prims.string -> lident) =
  fun str ->
    let uu____291 = FStar_List.map id_of_text (FStar_Util.split str ".") in
    lid_of_ids uu____291
let (lid_of_path : path -> FStar_Range.range -> lident) =
  fun path1 ->
    fun pos ->
      let ids = FStar_List.map (fun s -> mk_ident (s, pos)) path1 in
      lid_of_ids ids
let (text_of_lid : lident -> Prims.string) = fun lid1 -> lid1.str
let (lid_equals : lident -> lident -> Prims.bool) =
  fun l1 -> fun l2 -> l1.str = l2.str
let (ident_equals : ident -> ident -> Prims.bool) =
  fun id1 -> fun id2 -> id1.idText = id2.idText
let (range_of_lid : lident -> FStar_Range.range) =
  fun lid1 -> range_of_id lid1.ident
let (set_lid_range : lident -> FStar_Range.range -> lident) =
  fun l ->
    fun r ->
      let uu___69_347 = l in
      {
        ns = (uu___69_347.ns);
        ident =
          (let uu___71_349 = l.ident in
           { idText = (uu___71_349.idText); idRange = r });
        nsstr = (uu___69_347.nsstr);
        str = (uu___69_347.str)
      }
let (lid_add_suffix : lident -> Prims.string -> lident) =
  fun l ->
    fun s ->
      let path1 = path_of_lid l in
      let uu____361 = range_of_lid l in
      lid_of_path (FStar_List.append path1 [s]) uu____361
let (ml_path_of_lid : lident -> Prims.string) =
  fun lid1 ->
    let uu____367 =
      let uu____370 = path_of_ns lid1.ns in
      let uu____373 = let uu____376 = string_of_id lid1.ident in [uu____376] in
      FStar_List.append uu____370 uu____373 in
    FStar_All.pipe_left (FStar_String.concat "_") uu____367
let (string_of_lid : lident -> Prims.string) = fun lid1 -> lid1.str
let (qual_id : lident -> ident -> lident) =
  fun lid1 ->
    fun id ->
      let uu____394 = lid_of_ids (FStar_List.append lid1.ns [lid1.ident; id]) in
      let uu____395 = range_of_id id in set_lid_range uu____394 uu____395
let (nsstr : lident -> Prims.string) = fun l -> l.nsstr