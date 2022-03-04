package com.compiler

import com.natpryce.hamkrest.assertion.assertThat
import com.natpryce.hamkrest.equalTo
import org.junit.jupiter.api.Test
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.MethodSource

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

    @ParameterizedTest
    @MethodSource("compoundStatementsContainingPrintAnIdentifierValueAndAssignment")
    fun `it returns the number of arguments for a print as part of a compound statement`
                (compoundStatement: CompoundStatement) {
        assertThat(maxArgs(compoundStatement), equalTo(1))
    }

    @Test fun `it returns 0 for an assignment`() {
        assertThat(
            maxArgs(Assignment("a", Number(1))),
            equalTo(0)
        )
    }

    companion object {
        @JvmStatic
        fun compoundStatementsContainingPrintAnIdentifierValueAndAssignment() =
            listOf(
                CompoundStatement(
                    Assignment("a", Number(1)),
                    Print(TerminalExpression(Identifier("a")))
                ),
                CompoundStatement(
                    Print(TerminalExpression(Number(7))),
                    Assignment("a", Number(1)),
                ),
            )
    }
}
