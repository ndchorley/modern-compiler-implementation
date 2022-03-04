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

    @Test fun `it returns the maximum number of arguments in any print in any subexpression`() {
        val program =
            CompoundStatement(
                Assignment(
                    "a",
                    BinaryExpression(Number(5), Operator.PLUS, Number(3))
                ),
                CompoundStatement(
                    Assignment(
                        "b",
                        StatementThenExpression(
                            Print(
                                Pair(
                                    Identifier("a"),
                                    TerminalExpression(
                                        BinaryExpression(
                                            Identifier("a"),
                                            Operator.MINUS,
                                            Number(1)
                                        )
                                    )
                                )
                            ),
                            BinaryExpression(Number(10), Operator.TIMES, Identifier("a"))
                        )
                    ),
                    Print(TerminalExpression(Identifier("b")))
                )
            )

        assertThat(maxArgs(program), equalTo(2))
    }

    @Test fun `it returns the number of arguments in a print as part of an assignment`() {
        val assignment =
            Assignment(
                "a",
                StatementThenExpression(
                    Print(TerminalExpression(Identifier("a"))),
                    Number(1)
                )
            )

        assertThat(maxArgs(assignment), equalTo(1))
    }

    @Test fun `it returns 0 for an assignment`() {
        assertThat(
            maxArgs(Assignment("a", Number(1))),
            equalTo(0)
        )
    }
}
