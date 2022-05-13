package com.compiler

val ExpressionList.size: Int
    get() = when (this) {
        is TerminalExpression -> 1
        is Pair -> 1 + tail.size
    }