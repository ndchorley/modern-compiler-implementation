package com.compiler

fun maxArgs(statement: Statement): Int {
    return when (statement) {
        is Print -> statement.expressions.size
        is Assignment -> 0
        is CompoundStatement ->
            statement
                .findPrint()?.let { print -> maxArgs(print) }
                ?: run { TODO() }
    }
}

fun CompoundStatement.findPrint(): Print? =
    if (statement1 is Print) statement1
    else if (statement2 is Print) statement2
    else null
