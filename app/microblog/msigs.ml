module type PATCHABLE = sig
  type t
  type edit
  type patch = edit list
  val op_diff: t -> t -> patch
  val op_transform: patch -> patch -> patch * patch 
end

module type MERGEABLE = sig
  type t
  val merge3: ancestor:t -> t -> t -> t
end

module type RESOLVEABLE = sig
  type t
  val resolve: t -> t -> t
  include MERGEABLE with type t := t
end