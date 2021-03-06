(*
Module: Test_Postfix_Virtual
  Provides unit tests and examples for the <Postfix_Virtual> lens.
*)

module Test_Postfix_Virtual =

(* View: conf *)
let conf = "# a comment
virtual-alias.domain     anything
postmaster@virtual-alias.domain  postmaster
user1@virtual-alias.domain       address1
user-1@virtual-alias.domain       address1
user_2@virtual-alias.domain
    address2,
    address3
user+test@virtual-alias.domain
    address2,
    address3
root    robert.oot@domain.com
@example.net  root,postmaster
"

(* Test: Postfix_Virtual.lns *)
test Postfix_Virtual.lns get conf =
  { "#comment" = "a comment" }
  { "pattern" = "virtual-alias.domain"
    { "destination" = "anything" }
  }
  { "pattern" = "postmaster@virtual-alias.domain"
    { "destination" = "postmaster" }
  }
  { "pattern" = "user1@virtual-alias.domain"
    { "destination" = "address1" }
  }
  { "pattern" = "user-1@virtual-alias.domain"
    { "destination" = "address1" }
  }
  { "pattern" = "user_2@virtual-alias.domain"
    { "destination" = "address2" }
    { "destination" = "address3" }
  }
  { "pattern" = "user+test@virtual-alias.domain"
    { "destination" = "address2" }
    { "destination" = "address3" }
  }
  { "pattern" = "root"
    { "destination" = "robert.oot@domain.com" }
  }
  { "pattern" = "@example.net"
    { "destination" = "root" }
    { "destination" = "postmaster" }
  }
