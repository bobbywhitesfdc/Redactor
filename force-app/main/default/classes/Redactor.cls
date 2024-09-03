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
     **/ 
    private String processPatterns(final String input) {
        String result = input;
        for(RedactorExpression current : expressions ) {
            System.debug('Regex:' + current.matchingExpression);
            result = result.replaceAll(current.matchingExpression,current.redactionExpression);
            //result = replaceMatches(result,findMatches(result,current),current);
        }
        return result;
    }
    
    /**
	* Inner class to hold pattern matching detail
	**/ 
    public class MatchDetail {
        public Integer startPosition { get; set; }  
        public Integer endPosition   { get; set; }
        public String  text { get; set; }
    }
    
    /**
	* Helper function that takes an input string and finds all of the matches for a given RedactorExpression
	**/ 
    public List<MatchDetail> findMatches(final String input, final RedactorExpression exp) {
        Pattern pat = Pattern.compile(exp.matchingExpression);
        Matcher matcher = pat.matcher(input);
        List<MatchDetail> matches = new List<MatchDetail>(); 
        
        // Iterate until there are no more matches
        while(matcher.find()) {
            MatchDetail match = new MatchDetail();
            match.text    = matcher.group(); // text of matched pattern
            match.startPosition  = matcher.start(); // position in string where pattern starts
            match.endPosition = matcher.end() ;  // position after the last char of the pattern
            matches.add(match);
        }
        
        System.debug('Matches Count='+matches.size());
        return matches;
    }
    
    public String replaceMatches(final String input, final List<MatchDetail> matches, final RedactorExpression exp) {
        if (matches == null || matches.isEmpty()) {
            return input;
        } else {
            // Start at the beginning of the String
            String result = '';
            Integer position = 0;
            // Iterate through the matches
            for (MatchDetail current : matches) {
                // Copy the chunk between the last match and this one
                result += input.substring(position,current.startPosition-1);
                // Now insert the redacted placeholder
                result += exp.redactionExpression;
                // Update the position pointer to the end of match
                position = current.endPosition;
            }
            if (position < input.length()) {
                // Copy the remaining portion of the original input string after the last match
                result += input.substring(position,input.length()-1);
            }
            return result;
        }
    }
    

}