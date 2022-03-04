package com.compiler

import com.natpryce.hamkrest.assertion.assertThat
import com.natpryce.hamkrest.equalTo
import org.junit.jupiter.api.Test
import size


class MaxArgsTest {
    @Test fun `it returns the number of arguments in a print statement`() {
        val statement =
            Print(
                Pair(
                    Identifier("a"),
                    TerminalExpression(Number(4))
                )
            )

        assertThat(maxArgs(statement), equalTo(2))
    }


}

fun maxArgs(statement: Statement): Int =
    when (statement) {
        is Print -> statement.expressions.size
        else -> TODO()
    }

