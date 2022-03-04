package com.compiler

fun maxArgs(statement: Statement): Int {
    return when (statement) {
        is Print -> statement.expressions.size
        is Assignment -> 0
        is CompoundStatement ->
            when {
                statement.statement1 is Print && statement.statement2 is Print ->
                    maxOf(maxArgs(statement.statement1), maxArgs(statement.statement2))
                else -> TODO()
            }
    }
}

fun CompoundStatement.findPrint(): Print? =
    if (statement1 is Print) statement1
    else if (statement2 is Print) statement2
    else null
