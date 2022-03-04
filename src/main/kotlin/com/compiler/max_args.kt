package com.compiler

import size

fun maxArgs(statement: Statement): Int =
    when (statement) {
        is Print -> statement.expressions.size
        else -> TODO()
    }