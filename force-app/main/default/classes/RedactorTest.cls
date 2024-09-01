@isTest(isParallel=true)
public class RedactorTest {
    private static testmethod void empty() {
        final string original = '';
        
        // Placeholder until the implementation is done
        final string result = '';
        
        // Empty string should be the same
        System.AssertEquals(original,result);
    }
    
    private static testmethod void nullString() {
        final string original = null;
        
        // Placeholder until the implementation is done
        final string result = '';
        
        // Null string should be the same and shouldn't cause an exception
        System.AssertEquals(original,result);
    }
    
    private static testmethod void noMatches() {
        final string original = 'Nothing here to match and redact';
        
        // Placeholder until the implementation is done
        final string result = '';
        
        // Result string should be the same
        System.AssertEquals(original,result);
    }

    private static testmethod void oneMatch() {
        final string original = 'Redact the next token 123-45-4891 but leave rest';
        final string expected = 'Redact the next token ###SSN### but leave rest';
        
        // Placeholder until the implementation is done
        final string result = '';
        
        // Result string should redact the unwanted token
        System.AssertEquals(expected,result);
    }
     
    private static testmethod void multiMatch() {
        final string original = 'Redact the next token 123-45-4891 and 702-02-0202 but leave rest';
        final string expected = 'Redact the next token ###SSN### and ###SSN### but leave rest';
        
        // Placeholder until the implementation is done
        final string result = '';
        
        // Result string should redact the unwanted tokens
        System.AssertEquals(expected,result);
    }
    
}