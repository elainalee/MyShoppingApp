package leeJ.co.MyApp.InputFormatValidatorTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

import java.util.Arrays;
import java.util.Collection;

import static org.junit.Assert.assertEquals;

@RunWith(Parameterized.class)
public class PhoneNum_InputFormatValidatorTest extends InputFormatValidatorTest {

    public PhoneNum_InputFormatValidatorTest(String inputString, Boolean expectedResult) {
        super(inputString, expectedResult);
    }

    @Parameterized.Parameters
    public static Collection exampleNames() {
        return Arrays.asList(new Object[][]{
                { "123-456-7890", true },
                { "+868005551234", true },
                { "+86-800-555-1234", true },
                { "17184441122", true },
                { "7184441122", true },
                { "718.444.1122", false },
                { "1718.444.1122", false },
        });
    }

    @Test
    public void testInputFormatValidator() {
        assertEquals(expectedResult, inputFormatValidator.validatePhoneNum(inputString));
    }
}
