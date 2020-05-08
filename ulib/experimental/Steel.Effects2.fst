module Steel.Effects2

module Sem = Steel.Semantics.Hoare.MST
module Mem = Steel.Memory
module Act = Steel.Actions

open Steel.Memory
open Steel.Semantics.Instantiate

module Ins = Steel.Semantics.Instantiate

let join_preserves_interp (hp:hprop) (m0:hmem hp) (m1:mem{disjoint m0 m1})
: Lemma
  (interp hp (join m0 m1))
  [SMTPat (interp hp (join m0 m1))]
= intro_emp m1;
  intro_star hp emp m0 m1;
  affine_star hp emp (join m0 m1)

let ens_depends_only_on (#a:Type) (pre:hprop) (post:a -> hprop)
  (q:(hmem pre -> x:a -> hmem (post x) -> prop))

= //can join any disjoint mem to the pre-mem and q is still valid
  (forall x (m_pre:hmem pre) m_post (m:mem{disjoint m_pre m}).
     q m_pre x m_post <==> q (join m_pre m) x m_post) /\  //at this point we need to know interp pre (join m_pre m) -- use join_preserves_interp for that

  //can join any disjoint mem to the post-mem and q is still valid
  (forall x m_pre (m_post:hmem (post x)) (m:mem{disjoint m_post m}).
     q m_pre x m_post <==> q m_pre x (join m_post m))

type pre_t = hprop u#1
type post_t (a:Type) = a -> hprop u#1
type req_t (pre:pre_t) = q:(hmem pre -> prop){  //inlining depends only on
  forall (m0:hmem pre) (m1:mem{disjoint m0 m1}). q m0 <==> q (join m0 m1)
}
type ens_t (pre:pre_t) (a:Type u#a) (post:post_t u#a a) : Type u#(max 2 a) =
  q:(hmem pre -> x:a -> hmem (post x) -> prop){
    ens_depends_only_on pre post q
  }

#push-options "--warn_error -271"
let interp_depends_only_on_post (#a:Type) (hp:a -> hprop)
: Lemma
  (forall (x:a).
     (forall (m0:hmem (hp x)) (m1:mem{disjoint m0 m1}). interp (hp x) m0 <==> interp (hp x) (join m0 m1)))
= let aux (x:a)
    : Lemma
      (forall (m0:hmem (hp x)) (m1:mem{disjoint m0 m1}). interp (hp x) m0 <==> interp (hp x) (join m0 m1))
      [SMTPat ()]
    = interp_depends_only_on (hp x) in
  ()
#pop-options

let req_to_act_req (#pre:pre_t) (req:req_t pre) : Sem.l_pre #state pre =
  interp_depends_only_on pre;
  fun m -> interp pre m /\ req m

let ens_to_act_ens (#pre:pre_t) (#a:Type) (#post:post_t a) (ens:ens_t pre a post)
: Sem.l_post #state #a pre post
= interp_depends_only_on pre;
  interp_depends_only_on_post post;
  fun m0 x m1 -> interp pre m0 /\ interp (post x) m1 /\ ens m0 x m1

type repr (a:Type) (pre:pre_t) (post:post_t a) (req:req_t pre) (ens:ens_t pre a post) =
  Sem.action_t #state #a pre post (req_to_act_req req) (ens_to_act_ens ens)

assume val sl_implies (p q:hprop u#1) : Type0

assume val sl_implies_reflexive (p:hprop u#1)
: Lemma (p `sl_implies` p)
  [SMTPat (p `sl_implies` p)]

assume val sl_implies_interp (p q:hprop u#1)
: Lemma
  (requires p `sl_implies` q)
  (ensures forall (m:mem) (f:hprop). interp (p `star` f) m ==>  interp (q `star` f) m)
  [SMTPat (p `sl_implies` q)]

assume val sl_implies_interp_emp (p q:hprop u#1)
: Lemma
  (requires p `sl_implies` q)
  (ensures forall (m:mem). interp p m ==>  interp q m)
  [SMTPat (p `sl_implies` q)]

assume val sl_implies_preserves_frame (p q:hprop u#1)
: Lemma
  (requires p `sl_implies` q)
  (ensures
    forall (m1 m2:mem) (r:hprop).
      Sem.preserves_frame #state q r m1 m2 ==>
      Sem.preserves_frame #state p r m1 m2)
  [SMTPat (p `sl_implies` q)]

assume val sl_implies_preserves_frame_right (p q:hprop u#1)
: Lemma
  (requires p `sl_implies` q)
  (ensures
    forall (m1 m2:mem) (r:hprop).
      Sem.preserves_frame #state r p m1 m2 ==>
      Sem.preserves_frame #state r q m1 m2)
  [SMTPat (p `sl_implies` q)]


unfold
let return_req (p:hprop u#1) : req_t p = fun _ -> True

unfold
let return_ens (a:Type) (x:a) (p:a -> hprop u#1) : ens_t (p x) a p = fun _ r _ -> r == x

(*
 * Return is parametric in post
 * We rarely (never?) use M.return, but we will use it to define a ret
 *   function in the effect, that will be used to get around the scoping issues
 *   (cf. return-scoping.txt)
 *)
let return (a:Type) (x:a) (p:a -> hprop)
: repr a (p x) p (return_req (p x)) (return_ens a x p)
= fun _ -> x

(*
 * We allow weakening of post resource of f to pre resource of g
 *)
unfold
let bind_req (a:Type)
  (pre_f:pre_t) (post_f:post_t a)
  (req_f:req_t pre_f) (ens_f:ens_t pre_f a post_f)  
  (pre_g:a -> pre_t)
  (req_g:(x:a -> req_t (pre_g x)))
  (_:squash (forall (x:a). post_f x `sl_implies` pre_g x))
: req_t pre_f
= fun m0 ->
  req_f m0 /\
  (forall (x:a) (m1:hmem (post_f x)). ens_f m0 x m1 ==> (req_g x) m1)

unfold
let bind_ens (a:Type) (b:Type)
  (pre_f:pre_t) (post_f:post_t a)
  (req_f:req_t pre_f) (ens_f:ens_t pre_f a post_f)  
  (pre_g:a -> pre_t) (post_g:post_t b)
  (ens_g:(x:a -> ens_t (pre_g x) b post_g))
  (_:squash (forall (x:a). post_f x `sl_implies` pre_g x))
: ens_t pre_f b post_g
= fun m0 y m2 ->
  req_f m0 /\
  (exists (x:a) (m1:hmem (post_f x)). ens_f m0 x m1 /\ (ens_g x) m1 y m2)

let bind (a:Type) (b:Type)
  (pre_f:pre_t) (post_f:post_t a)
  (req_f:req_t pre_f) (ens_f:ens_t pre_f a post_f)  
  (pre_g:a -> pre_t) (post_g:post_t b)
  (req_g:(x:a -> req_t (pre_g x))) (ens_g:(x:a -> ens_t (pre_g x) b post_g))
  (p:squash (forall (x:a). post_f x `sl_implies` pre_g x))
  (f:repr a pre_f post_f req_f ens_f)
  (g:(x:a -> repr b (pre_g x) post_g (req_g x) (ens_g x)))
: repr b
    pre_f
    post_g
    (bind_req a pre_f post_f req_f ens_f pre_g req_g p)
    (bind_ens a b pre_f post_f req_f ens_f pre_g post_g ens_g p)
= fun _ ->
  let x = f () in
  (g x) ()


(*
 * TODO: don't use polymonadic binds for lift anymore
 *)

(*
 * f <: g
 *)

unfold
let subcomp_pre (a:Type)
  (pre_f:pre_t) (post_f:post_t a) (req_f:req_t pre_f) (ens_f:ens_t pre_f a post_f)
  (pre_g:pre_t) (post_g:post_t a) (req_g:req_t pre_g) (ens_g:ens_t pre_g a post_g)
  (_:squash (pre_g `sl_implies` pre_f))
  (_:squash (forall (x:a). post_f x `sl_implies` post_g x))
: pure_pre
= (forall (m0:hmem pre_g). req_g m0 ==> req_f m0) /\
  (forall (m0:hmem pre_g) (x:a) (m1:hmem (post_f x)). ens_f m0 x m1 ==> ens_g m0 x m1)

let subcomp (a:Type)
  (pre_f:pre_t) (post_f:post_t a) (req_f:req_t pre_f) (ens_f:ens_t pre_f a post_f)
  (pre_g:pre_t) (post_g:post_t a) (req_g:req_t pre_g) (ens_g:ens_t pre_g a post_g)
  (p1:squash (pre_g `sl_implies` pre_f))
  (p2:squash (forall (x:a). post_f x `sl_implies` post_g x))
  (f:repr a pre_f post_f req_f ens_f)
: Pure (repr a pre_g post_g req_g ens_g)
  (requires subcomp_pre a pre_f post_f req_f ens_f pre_g post_g req_g ens_g p1 p2)
  (ensures fun _ -> True)
= f

unfold
let if_then_else_req (pre:pre_t)
  (req_then:req_t pre) (req_else:req_t pre)
  (p:Type0)
: req_t pre
= fun h -> (p ==> req_then h) /\ ((~ p) ==> req_else h)

unfold
let if_then_else_ens (a:Type) (pre:pre_t) (post:post_t a)
  (ens_then:ens_t pre a post) (ens_else:ens_t pre a post)
  (p:Type0)
: ens_t pre a post
= fun h0 x h1 -> (p ==> ens_then h0 x h1) /\ ((~ p) ==> ens_else h0 x h1)

let if_then_else (a:Type) (pre:pre_t) (post:post_t a)
  (req_then:req_t pre) (ens_then:ens_t pre a post)
  (req_else:req_t pre) (ens_else:ens_t pre a post)
  (f:repr a pre post req_then ens_then)
  (g:repr a pre post req_else ens_else)
  (p:Type0)
: Type
= repr a pre post
    (if_then_else_req pre req_then req_else p)
    (if_then_else_ens a pre post ens_then ens_else p)

reifiable reflectable
layered_effect {
  SteelF: a:Type -> pre:pre_t -> post:post_t a -> req_t pre -> ens_t pre a post -> Effect
  with repr = repr;
       return = return;
       bind = bind;
       subcomp = subcomp;
       if_then_else = if_then_else
}

new_effect Steel = SteelF

(*
 * Keeping f_frame aside for now
 *)
let frame_aux (#a:Type) (#pre:pre_t) (#post:post_t a) (#req:req_t pre) (#ens:ens_t pre a post)
  ($f:repr a pre post req ens) (frame:hprop)
: repr a (pre `star` frame) (fun x -> post x `star` frame) req ens
= fun _ ->
  Sem.run #state #_ #_ #_ #_ #_ (Sem.Frame (Sem.Act f) frame (fun _ -> True))


(*
 * Onto polymonadic binds
 *)

(*
 * First the bind between two unframed computations
 *
 * Add a frame to each
 *)

unfold
let bind_steel_steel_req (a:Type)
  (pre_f:pre_t) (post_f:post_t a)
  (req_f:req_t pre_f) (ens_f:ens_t pre_f a post_f)  
  (pre_g:a -> pre_t)
  (req_g:(x:a -> req_t (pre_g x)))
  (frame_f:hprop) (frame_g:hprop)
  (_:squash (forall (x:a). (post_f x `star` frame_f) `sl_implies` (pre_g x `star` frame_g)))
: req_t (pre_f `star` frame_f)
= fun m0 ->
  req_f m0 /\
  (forall (x:a) (m1:hmem (post_f x `star` frame_f)). ens_f m0 x m1 ==> (req_g x) m1)

unfold
let bind_steel_steel_ens (a:Type) (b:Type)
  (pre_f:pre_t) (post_f:post_t a)
  (req_f:req_t pre_f) (ens_f:ens_t pre_f a post_f)  
  (pre_g:a -> pre_t) (post_g:post_t b)
  (ens_g:(x:a -> ens_t (pre_g x) b post_g))
  (frame_f:hprop) (frame_g:hprop)
  (_:squash (forall (x:a). (post_f x `star` frame_f) `sl_implies` (pre_g x `star` frame_g)))
: ens_t (pre_f `star` frame_f) b (fun y -> post_g y `star` frame_g)
= fun m0 y m2 ->
  req_f m0 /\
  (exists (x:a) (m1:hmem (post_f x `star` frame_f)). ens_f m0 x m1 /\ (ens_g x) m1 y m2)

let bind_steel_steel (a:Type) (b:Type)
  (pre_f:pre_t) (post_f:post_t a)
  (req_f:req_t pre_f) (ens_f:ens_t pre_f a post_f)  
  (pre_g:a -> pre_t) (post_g:post_t b)
  (req_g:(x:a -> req_t (pre_g x))) (ens_g:(x:a -> ens_t (pre_g x) b post_g))
  (frame_f:hprop) (frame_g:hprop)
  (p:squash (forall (x:a). (post_f x `star` frame_f) `sl_implies` (pre_g x `star` frame_g)))
  (f:repr a pre_f post_f req_f ens_f)
  (g:(x:a -> repr b (pre_g x) post_g (req_g x) (ens_g x)))
: repr b
    (pre_f `star` frame_f)
    (fun y -> post_g y `star` frame_g)
    (bind_steel_steel_req a pre_f post_f req_f ens_f pre_g req_g frame_f frame_g p)
    (bind_steel_steel_ens a b pre_f post_f req_f ens_f pre_g post_g ens_g frame_f frame_g p)
= fun _ ->
  let x = frame_aux f frame_f () in
  frame_aux (g x) frame_g ()


(*
 * Note that the output is a framed computation, hence SteelF
 *)

polymonadic_bind (Steel, Steel) |> SteelF = bind_steel_steel


(*
 * Steel, SteelF: frame the first computation
 *)

unfold
let bind_steel_steelf_req (a:Type)
  (pre_f:pre_t) (post_f:post_t a)
  (req_f:req_t pre_f) (ens_f:ens_t pre_f a post_f)  
  (pre_g:a -> pre_t)
  (req_g:(x:a -> req_t (pre_g x)))
  (frame_f:hprop)
  (_:squash (forall (x:a). (post_f x `star` frame_f) `sl_implies` pre_g x))
: req_t (pre_f `star` frame_f)
= fun m0 ->
  req_f m0 /\
  (forall (x:a) (m1:hmem (post_f x `star` frame_f)). ens_f m0 x m1 ==> (req_g x) m1)

unfold
let bind_steel_steelf_ens (a:Type) (b:Type)
  (pre_f:pre_t) (post_f:post_t a)
  (req_f:req_t pre_f) (ens_f:ens_t pre_f a post_f)  
  (pre_g:a -> pre_t) (post_g:post_t b)
  (ens_g:(x:a -> ens_t (pre_g x) b post_g))
  (frame_f:hprop)
  (_:squash (forall (x:a). (post_f x `star` frame_f) `sl_implies` pre_g x))
: ens_t (pre_f `star` frame_f) b post_g
= fun m0 y m2 ->
  req_f m0 /\
  (exists (x:a) (m1:hmem (post_f x `star` frame_f)). ens_f m0 x m1 /\ (ens_g x) m1 y m2)

let bind_steel_steelf (a:Type) (b:Type)
  (pre_f:pre_t) (post_f:post_t a)
  (req_f:req_t pre_f) (ens_f:ens_t pre_f a post_f)  
  (pre_g:a -> pre_t) (post_g:post_t b)
  (req_g:(x:a -> req_t (pre_g x))) (ens_g:(x:a -> ens_t (pre_g x) b post_g))
  (frame_f:hprop)
  (p:squash (forall (x:a). (post_f x `star` frame_f) `sl_implies` pre_g x))
  (f:repr a pre_f post_f req_f ens_f)
  (g:(x:a -> repr b (pre_g x) post_g (req_g x) (ens_g x)))
: repr b
    (pre_f `star` frame_f)
    post_g
    (bind_steel_steelf_req a pre_f post_f req_f ens_f pre_g req_g frame_f p)
    (bind_steel_steelf_ens a b pre_f post_f req_f ens_f pre_g post_g ens_g frame_f p)
= fun _ ->
  let x = frame_aux f frame_f () in
  (g x) ()


polymonadic_bind (Steel, SteelF) |> SteelF = bind_steel_steelf


(*
 * SteelF, Steel: frame the second computation
 *)

unfold
let bind_steelf_steel_req (a:Type)
  (pre_f:pre_t) (post_f:post_t a)
  (req_f:req_t pre_f) (ens_f:ens_t pre_f a post_f)  
  (pre_g:a -> pre_t)
  (req_g:(x:a -> req_t (pre_g x)))
  (frame_g:hprop)
  (_:squash (forall (x:a). post_f x `sl_implies` (pre_g x `star` frame_g)))
: req_t pre_f
= fun m0 ->
  req_f m0 /\
  (forall (x:a) (m1:hmem (post_f x)). ens_f m0 x m1 ==> (req_g x) m1)

unfold
let bind_steelf_steel_ens (a:Type) (b:Type)
  (pre_f:pre_t) (post_f:post_t a)
  (req_f:req_t pre_f) (ens_f:ens_t pre_f a post_f)  
  (pre_g:a -> pre_t) (post_g:post_t b)
  (ens_g:(x:a -> ens_t (pre_g x) b post_g))
  (frame_g:hprop)
  (_:squash (forall (x:a). post_f x `sl_implies` (pre_g x `star` frame_g)))
: ens_t pre_f b (fun y -> post_g y `star` frame_g)
= fun m0 y m2 ->
  req_f m0 /\
  (exists (x:a) (m1:hmem (post_f x)). ens_f m0 x m1 /\ (ens_g x) m1 y m2)

let bind_steelf_steel (a:Type) (b:Type)
  (pre_f:pre_t) (post_f:post_t a)
  (req_f:req_t pre_f) (ens_f:ens_t pre_f a post_f)  
  (pre_g:a -> pre_t) (post_g:post_t b)
  (req_g:(x:a -> req_t (pre_g x))) (ens_g:(x:a -> ens_t (pre_g x) b post_g))
  (frame_g:hprop)
  (p:squash (forall (x:a). post_f x `sl_implies` (pre_g x `star` frame_g)))
  (f:repr a pre_f post_f req_f ens_f)
  (g:(x:a -> repr b (pre_g x) post_g (req_g x) (ens_g x)))
: repr b
    pre_f
    (fun y -> post_g y `star` frame_g)
    (bind_steelf_steel_req a pre_f post_f req_f ens_f pre_g req_g frame_g p)
    (bind_steelf_steel_ens a b pre_f post_f req_f ens_f pre_g post_g ens_g frame_g p)
= fun _ ->
  let x = f () in
  frame_aux (g x) frame_g ()


polymonadic_bind (SteelF, Steel) |> SteelF = bind_steelf_steel


(*
 * SteelF, SteelF: no framing, use the effect bind
 *)

(*
 * PURE, Steel(F) bind
 *)

assume WP_monotonic :
  forall (a:Type) (wp:pure_wp a).
    (forall p q. (forall x. p x ==>  q x) ==>  (wp p ==>  wp q))


unfold
let bind_pure_steel__req (a:Type) (wp:pure_wp a)
  (pre:pre_t) (req:a -> req_t pre)
: req_t pre
= fun m -> wp (fun x -> (req x) m) /\ as_requires wp

unfold
let bind_pure_steel__ens (a:Type) (b:Type)
  (wp:pure_wp a)
  (pre:pre_t) (post:post_t b) (ens:a -> ens_t pre b post)
: ens_t pre b post
= fun m0 r m1 -> as_requires wp /\ (exists (x:a). as_ensures wp x /\ (ens x) m0 r m1)

let bind_pure_steel_ (a:Type) (b:Type)
  (wp:pure_wp a)
  (pre:pre_t) (post:post_t b) (req:a -> req_t pre) (ens:a -> ens_t pre b post)
  (f:unit -> PURE a wp) (g:(x:a -> repr b pre post (req x) (ens x)))
: repr b
    pre
    post
    (bind_pure_steel__req a wp pre req)
    (bind_pure_steel__ens a b wp pre post ens)
= fun _ ->
  let x = f () in
  (g x) ()

polymonadic_bind (PURE, SteelF) |> SteelF = bind_pure_steel_

polymonadic_bind (PURE, Steel) |> Steel = bind_pure_steel_


(*
 * No Steel(F), PURE bind
 *
 * Use the steel_ret function below to return the PURE computation
 *
 * Note it is in SteelF (i.e. framed already)
 *)
let steel_ret (#a:Type) (#p:a -> hprop u#1) (x:a)
: SteelF a (p x) p (fun _ -> True) (fun _ r _ -> r == x)
= SteelF?.reflect (fun _ -> x)


(*
 * subcomp relation from SteelF to Steel
 *)

polymonadic_subcomp SteelF <: Steel = subcomp


(*
 * Annotations without the req and ens
 *)

effect SteelT (a:Type) (pre:pre_t) (post:post_t a) =
  Steel a pre post (fun _ -> True) (fun _ _ _ -> True)
