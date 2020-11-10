package leeJ.co.MyApp.InputFormatValidatorTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

import java.util.Arrays;
import java.util.Collection;

import static org.junit.Assert.assertEquals;

@RunWith(Parameterized.class)
public class Username_InputFormatValidatorTest extends InputFormatValidatorTest {

    public Username_InputFormatValidatorTest(String inputString, Boolean expectedResult) {
        super(inputString, expectedResult);
    }

    @Parameterized.Parameters
    public static Collection exampleNames() {
        return Arrays.asList(new Object[][]{
                { "Person", true },
                { "person", true },
                { "person_A", true },
                { "person_123", true },
                { "person_A_123", true },
                { "123_Person", true },
                { "12345", true },
                { "person ", false },
                { "person A", false },
                { " person A", false },
                { "person_123-", false },
                { "person@whereever", false }
        });
    }

    @Test
    public void testInputFormatValidator() {
        assertEquals(expectedResult, inputFormatValidator.matchesUsernameFormat(inputString));
    }
}
