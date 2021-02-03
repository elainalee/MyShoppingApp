package leeJ.co.MyApp.InputFormatValidatorTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

import java.util.Arrays;
import java.util.Collection;

import static org.junit.Assert.assertEquals;

@RunWith(Parameterized.class)
public class Name_InputFormatValidatorTest extends InputFormatValidatorTest {


    public Name_InputFormatValidatorTest(String inputString, Boolean expectedResult) {
        super(inputString, expectedResult);
    }

    @Parameterized.Parameters
    public static Collection exampleNames() {
        return Arrays.asList(new Object[][]{
                { "Person A", true },
                { "PersonA", true },
                { "Person", true },
                { " Person", false },
                { "Person ", false },
                { "Person  A", false },
                { "Person A Person", false },
        });
    }

    @Test
    public void testInputFormatValidator() {
        assertEquals(expectedResult, inputFormatValidator.matchesNameFormat(inputString));
    }

}