
open Compiler.Grammar
let program = CompoundStatement (
          Assignment ("a", BinaryExpression (Number (5), Plus, Number (3))),
          CompoundStatement (
            Assignment (
              "b",
              StatementThenExpression (
                Print [
                  Identifier ("a");
                  BinaryExpression (Identifier ("a"), Minus, Number (1))
                ],
                BinaryExpression (Number (10), Times, Identifier ("a"))
              )
            ),
            Print [Identifier ("b")]
          )
        )
