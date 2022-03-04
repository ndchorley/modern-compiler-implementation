import com.compiler.ExpressionList
import com.compiler.Pair
import com.compiler.TerminalExpression

val ExpressionList.size: Int
    get() = when (this) {
        is TerminalExpression -> 1
        is Pair -> 1 + tail.size
    }