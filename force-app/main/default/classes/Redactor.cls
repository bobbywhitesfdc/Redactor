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
        // No-op implementation initially
        return input;
    }
}