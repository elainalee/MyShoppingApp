package leeJ.co.MyApp.InputFormatValidatorTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

import java.util.Arrays;
import java.util.Collection;

import static org.junit.Assert.assertEquals;

@RunWith(Parameterized.class)
public class Email_InputFormatValidatorTest extends InputFormatValidatorTest {

    public Email_InputFormatValidatorTest(String inputString, Boolean expectedResult) {
        super(inputString, expectedResult);
    }

    @Parameterized.Parameters
    public static Collection exampleNames() {
        return Arrays.asList(new Object[][]{
                { "person.com@whereever.com", true },
                { "person._@whereever.com", true },
                { "person._-@whereever.com", true },
                { "person.@whereever.com", true },
                { "person@whereever.com", true },
                { "person@whereever.c", true },
                { "person@whereever.ccom", true },
                { "person_123@whereever.com", true },
                { "person_A_123@whereever.com", true },
                { "123_Person@whereever.com", true },
                { "12345@whereever.com", true },

                { "person @whereever. ccom.", false },
                { " person@whereever.ccom.", false },
                { "person @whereever.ccom.", false },
                { "person@whereever.ccom.", false },
                { "person@whereever.ccom.com", false },
                { "person.com@whereever.com ", false },
        });
    }

    @Test
    public void testInputFormatValidator() {
        assertEquals(expectedResult, inputFormatValidator.matchesEmailFormat(inputString));
    }
}
