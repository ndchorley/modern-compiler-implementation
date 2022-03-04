package com.compiler

import com.natpryce.hamkrest.assertion.assertThat
import com.natpryce.hamkrest.equalTo
import org.junit.jupiter.api.Test


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

    @Test fun `it returns 0 for an assignment`() {
        assertThat(
            maxArgs(Assignment("a", Number(1))),
            equalTo(0)
        )
    }
}
