package leeJ.co.MyApp.InputFormatValidatorTest;

import org.junit.Before;

import leeJ.co.MyApp.InputFormatValidator;

public class Abstract_InputFormatValidatorTest {
    protected String inputString;
    protected Boolean expectedResult;
    protected InputFormatValidator inputFormatValidator;

    @Before
    public void initData() {
        inputFormatValidator = new InputFormatValidator();
    }

    public Abstract_InputFormatValidatorTest(String inputString, Boolean expectedResult) {
        this.inputString = inputString;
        this.expectedResult = expectedResult;
    }

}
