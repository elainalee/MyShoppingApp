package leeJ.co.MyApp;
//
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

import java.util.Arrays;
import java.util.Collection;
//
import org.junit.Test;

import static org.junit.Assert.assertEquals;
//
///**
// * Example local unit test, which will execute on the development machine (host).
// *
// * @see <a href="http://d.android.com/tools/testing">Testing documentation</a>
// */
@RunWith(Parameterized.class)
public class InputFormatValidatorTest {

    private String inputString;
    private Boolean expectedResult;
    private InputFormatValidator inputFormatValidator;

    @Before
    public void initData() {
        inputFormatValidator = new InputFormatValidator();
    }

    public InputFormatValidatorTest(String inputString, Boolean expectedResult) {
        this.inputString = inputString;
        this.expectedResult = expectedResult;
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

//    @Parameterized.Parameters
//    public static Collection exampleUserNames() {
//        return Arrays.asList(new Object[][]{
////                { "mkyong34", true },
////                { "mkyong_2002", true },
////                { "mkyong-2002", true },
////                { "mk3-4_yong", true },
//                {"mk@yong", false}
//        });
//    }

    @Test
    public void testInputFormatValidator() {
        assertEquals(expectedResult, inputFormatValidator.validateName(inputString));
    }

}