package com.compiler

sealed class Statement

data class CompoundStatement(val statement1: Statement, val statement2: Statement) : Statement()
data class Assignment(val identifier: String, val expression: Expression): Statement()
data class Print(val expressions: ExpressionList): Statement()

sealed class Expression

data class Identifier(val value: String) : Expression()
data class Number(val value: Int): Expression()
data class BinaryExpression(val left: Expression, val operator: Operator, val right: Expression) : Expression()
data class StatementThenExpression(val statement: Statement, val expression: Expression): Expression()

sealed class ExpressionList
data class Pair(val head: Expression, val tail: ExpressionList): ExpressionList()
data class TerminalExpression(val expression: Expression): ExpressionList()

enum class Operator { PLUS, MINUS, TIMES, DIVIDE }

