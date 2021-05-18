package test.com.availity.main;

import java.com.availity.main.Checker;

import static org.junit.jupiter.api.Assertions.*;

class CheckerTest {
    String input;

    @org.junit.jupiter.api.BeforeEach
    void setUp() {
        input = "123+-((00))(@#$%%)".intern();
    }

    @org.junit.jupiter.api.AfterEach
    void tearDown() {
        input = null;
    }

    @org.junit.jupiter.api.Test
    void checkForBalancedParentheses() {
        Boolean result = Boolean.FALSE;
        try{
            result = Checker.checkForBalancedParentheses(input);
        }
        catch (RuntimeException ignored){

        }
        assertEquals(Boolean.TRUE, result);
    }
}