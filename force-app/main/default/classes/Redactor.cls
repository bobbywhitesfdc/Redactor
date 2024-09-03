/**
 * Worker class that performs redaction on strings based on 
 * regular expressions.
 * 
 * The caller supplies the matching expressions and replacement mask
 * 
 * The intent is that this class would be once in trigger/batch/controller
 * and used iteratively.
 * 
 **/ 
public inherited sharing class Redactor {
    
    protected final List<RedactorExpression> expressions;
    
    // Default Constructor
    public Redactor() {
        expressions= new List<RedactorExpression>();
    }
    
    // Normal constructor
    public Redactor(final List<RedactorExpression> expParam) {
        expressions = expParam;
    }
    
    // Worker method that does the redaction
    public string process(final String input) {
        if (input == null || input.length()==0) {
        	return input;
        } else {
            return processPatterns(input);
        }
    }
    
    /**
     * Iterate throught the matching Patterns
     * Supports multiples (e.g. SSN,  Email)
     **/ 
    private String processPatterns(final String input) {
        String result = input;
        for(RedactorExpression current : expressions ) {
            System.debug('Regex:' + current.matchingExpression);
            result = result.replaceAll(current.matchingExpression,current.redactionExpression);
        }
        return result;
    }   
}