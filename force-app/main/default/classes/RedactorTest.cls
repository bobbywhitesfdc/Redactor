@isTest(isParallel=true)
public class RedactorTest {
    private static testmethod void empty() {
        final string original = '';
        
        Test.StartTest();
        
        // Run the redactor
        final string result = getRedactorSSNOnly().process(original);
        
        Test.StopTest();
        
        // Empty string should be the same
        System.AssertEquals(original,result);
    }
    
    private static testmethod void nullString() {
        final string original = null;
        
        
        Test.StartTest();
        
        // Run the redactor
        final string result = getRedactorSSNOnly().process(original);
        
        Test.StopTest();
        
        // Null string should be the same and shouldn't cause an exception
        System.AssertEquals(original,result);
    }
    
    private static testmethod void noMatchesSSN() {
        final string original = 'Nothing here to match and redact';
        
        
        Test.StartTest();
        
        // Run the redactor
        final string result = getRedactorSSNOnly().process(original);
        
        Test.StopTest();
        
        // Result string should be the same
        System.AssertEquals(original,result);
    }

    private static testmethod void oneMatchSSN() {
        final string original = 'Redact the next token 123-45-4891 but leave rest';
        final string expected = 'Redact the next token ###SSN### but leave rest';
        
        
        Test.StartTest();
        
        // Run the redactor
        final string result = getRedactorSSNOnly().process(original);
        
        Test.StopTest();
        
        // Result string should redact the unwanted token
        System.AssertEquals(expected,result);
    }
     
    private static testmethod void multiMatchSSN() {
        final string original = 'Redact the next token 123-45-4891 and 702-02-0202 but leave rest';
        final string expected = 'Redact the next token ###SSN### and ###SSN### but leave rest';
        
        
        Test.StartTest();
        
        // Run the redactor
        final string result = getRedactorSSNOnly().process(original);
        
        Test.StopTest();
        
        // Result string should redact the unwanted tokens
        System.AssertEquals(expected,result);
    }
    
    private static testmethod void oneMatchEmail() {
        final string original = 'Redact the next token moose.white@example.com but leave rest';
        final string expected = 'Redact the next token ###Email### but leave rest';
        
        
        Test.StartTest();
        
        // Run the redactor
        final string result = getRedactorMulti().process(original);
        
        Test.StopTest();
        
        // Result string should redact the unwanted token
        System.AssertEquals(expected,result);
    }
     
    private static testmethod void multiMatchEmail() {
        final string original = 'Redact the next token moose.white@example.com and\n moose.white@adp.com but leave rest';
        final string expected = 'Redact the next token ###Email### and\n ###Email### but leave rest';
        
        
        Test.StartTest();
        
        // Run the redactor
        final string result = getRedactorMulti().process(original);
        
        Test.StopTest();
        
        // Result string should redact the unwanted tokens
        System.AssertEquals(expected,result);
    }
    
    private static testmethod void multiMatchMix() {
        final string original = 'Redact the next token moose.white@example.com and\n moose.white@adp.com but leave rest.  Taxid: 567-27-7473';
        final string expected = 'Redact the next token ###Email### and\n ###Email### but leave rest.  Taxid: ###SSN###';
        
        
        Test.StartTest();
        
        // Run the redactor
        final string result = getRedactorMulti().process(original);
        
        Test.StopTest();
        
        // Result string should redact the unwanted tokens
        System.AssertEquals(expected,result);
    }

    
    /**
     * Helper method to initialize the redactor for this test
     **/ 
    private static Redactor getRedactorSSNOnly() {
        final List<RedactorExpression> config = new List<RedactorExpression>();
        final RedactorExpression exp1 = new RedactorExpression();
        exp1.matchingExpression='(?!(\\d){3}(-| |)\\1{2}\\2\\1{4})(?!666|000|9\\d{2})(\\b\\d{3}(-| |)(?!00)\\d{2}\\4(?!0{4})\\d{4}\\b)';
        exp1.redactionExpression='###SSN###';
        exp1.name='SSN';
        config.add(exp1);
        return new Redactor(config);
    }
    
    /**
     * Helper method to initialize the redactor for this test
    **/ 
    private static Redactor getRedactorMulti() {
        final List<RedactorExpression> config = new List<RedactorExpression>();
        final RedactorExpression exp1 = new RedactorExpression();
        exp1.matchingExpression='(?!(\\d){3}(-| |)\\1{2}\\2\\1{4})(?!666|000|9\\d{2})(\\b\\d{3}(-| |)(?!00)\\d{2}\\4(?!0{4})\\d{4}\\b)';
        exp1.redactionExpression='###SSN###';
        exp1.name='SSN';
        config.add(exp1);
        final RedactorExpression exp2 = new RedactorExpression();
        exp2.matchingExpression='([\\w\\.-]+@[\\w\\.-]+\\.[\\w]+)';
        exp2.redactionExpression='###Email###';
        exp2.name='Email';
        config.add(exp2);
        return new Redactor(config);
    }

    
}