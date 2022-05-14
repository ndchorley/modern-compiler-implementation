type binary_operator = Plus | Minus | Times | Divide

type statement =
  | CompoundStatement of statement * statement
  | Assignment of string * expression
  | Print of expression list
and
expression =
  | Identifier of string
  | Number of int
  | BinaryExpression of expression * binary_operator * expression
  | StatementThenExpression of statement * expression
