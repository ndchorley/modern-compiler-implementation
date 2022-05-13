type id = string

type binary_operator = Plus | Minus | Times | Divide

type statement =
  | CompoundStatement of statement * statement
  | Assignment of id * expression
  | Print of expression list
and
expression =
  | Identifier of id
  | Number of int
  | BinaryExpression of expression * binary_operator * expression
  | StatementThenExpression of statement * expression
