(*
   Copyright 2008-2018 Microsoft Research

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*)
module FStar.DM4F.Heap.IntStoreFixed

open FStar.Seq

let store_size = 10

val id : eqtype
val heap : eqtype

val to_id (n:nat{n < store_size}) : id

val index (h:heap) (i:id) : int
let sel = index

val upd (h:heap) (i:id) (x:int) : heap

val create (x:int) : heap

val lemma_index_upd1: s:heap -> n:id -> v:int -> Lemma
  (requires True)
  (ensures (index (upd s n v) n == v))
  [SMTPat (index (upd s n v) n)]

val lemma_index_upd2: s:heap -> n:id -> v:int -> i:id{i<>n} -> Lemma
  (requires True)
  (ensures (index (upd s n v) i == index s i))
  [SMTPat (index (upd s n v) i)]

val lemma_index_create: v:int -> i:id -> Lemma
  (requires True)
  (ensures (index (create v) i == v))
  [SMTPat (index (create v) i)]
