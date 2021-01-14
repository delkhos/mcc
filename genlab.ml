
open Printf

let counter = ref 0

let rec genlab func =
  incr counter;
  sprintf ".%s_%d" func (!counter)
