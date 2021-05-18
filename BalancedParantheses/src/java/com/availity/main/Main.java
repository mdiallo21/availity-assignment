package java.com.availity.main;
/*
@Author
 Mamadou Dian Diallo
 */
public class Main {
    //Run this method a pass the string to test as command line argument
    public static void main(String[] args){
        //Making sure there is exactly one argument passed for check.
        if(args == null || args.length !=  1){
            return;
        }
        try{
            System.out.println(Checker.checkForBalancedParentheses(args[0]));
        }
        catch (RuntimeException ex){
            System.out.println(false);
        }

    }
}
