package com.compiler

fun maxArgs(statement: Statement): Int =
    when (statement) {
        is Print -> statement.expressions.size
        is Assignment -> 0
        is CompoundStatement ->
            when {
                statement.statement1 is Print && statement.statement2 is Print ->
                    maxOf(maxArgs(statement.statement1), maxArgs(statement.statement2))
                else -> TODO()
            }
    }
