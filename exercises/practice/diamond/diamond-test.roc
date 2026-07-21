# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/diamond/canonical-data.json
# File last updated on 2026-06-22

import Diamond exposing [diamond]

# Degenerate case with a single 'A' row
expect {
	result = diamond('A')
	expected = "A"
	result == expected
}

# Degenerate case with no row containing 3 distinct groups of spaces
expect {
	result = diamond('B')
	expected = 
		\\ A 
		\\B B
		\\ A 

	result == expected
}

# Smallest non-degenerate case with odd diamond side length
expect {
	result = diamond('C')
	expected = 
		\\  A  
		\\ B B 
		\\C   C
		\\ B B 
		\\  A  

	result == expected
}

# Smallest non-degenerate case with even diamond side length
expect {
	result = diamond('D')
	expected = 
		\\   A   
		\\  B B  
		\\ C   C 
		\\D     D
		\\ C   C 
		\\  B B  
		\\   A   

	result == expected
}

# Largest possible diamond
expect {
	result = diamond('Z')
	expected = 
		\\                         A                         
		\\                        B B                        
		\\                       C   C                       
		\\                      D     D                      
		\\                     E       E                     
		\\                    F         F                    
		\\                   G           G                   
		\\                  H             H                  
		\\                 I               I                 
		\\                J                 J                
		\\               K                   K               
		\\              L                     L              
		\\             M                       M             
		\\            N                         N            
		\\           O                           O           
		\\          P                             P          
		\\         Q                               Q         
		\\        R                                 R        
		\\       S                                   S       
		\\      T                                     T      
		\\     U                                       U     
		\\    V                                         V    
		\\   W                                           W   
		\\  X                                             X  
		\\ Y                                               Y 
		\\Z                                                 Z
		\\ Y                                               Y 
		\\  X                                             X  
		\\   W                                           W   
		\\    V                                         V    
		\\     U                                       U     
		\\      T                                     T      
		\\       S                                   S       
		\\        R                                 R        
		\\         Q                               Q         
		\\          P                             P          
		\\           O                           O           
		\\            N                         N            
		\\             M                       M             
		\\              L                     L              
		\\               K                   K               
		\\                J                 J                
		\\                 I               I                 
		\\                  H             H                  
		\\                   G           G                   
		\\                    F         F                    
		\\                     E       E                     
		\\                      D     D                      
		\\                       C   C                       
		\\                        B B                        
		\\                         A                         

	result == expected
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
