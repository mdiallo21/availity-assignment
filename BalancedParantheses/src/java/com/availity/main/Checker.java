package java.com.availity.main;
/*
@Author
 Mamadou Dian Diallo
 */
public class Checker {
    private static final int OPEN_PARENTHESIS = '\u0028';
    private static final int CLOSE_PARENTHESIS = '\u0029';

    public static  boolean checkForBalancedParentheses( String expression){
        if(expression == null || expression.isBlank()){
            return false;
        }
        return expression.intern().chars().reduce(0, (accumulator, currentValue) -> {
            //If the current value matches the open parenthesis we increment the accumulator
            if(currentValue == OPEN_PARENTHESIS){
                return ++accumulator;
            }
            //If the current value matches the close parenthesis,we decrement the accumulator
            else if(currentValue == CLOSE_PARENTHESIS){
                //The first encounter of ) without a ( will return false
                if(--accumulator < 0){
                    throw new RuntimeException();
                }
                return accumulator;
            }
            return accumulator;
            // The final result will be zero is the expression is balanced
        })== 0;
    }
}
