classdef State < handle
    
    properties 
        
        inventory_value;
        visited_counter;
        transition_counter;
        transition_probabilities;
        
    end
    
methods
    function obj = State(inventory_value)   
        obj.inventory_value = inventory_value; 
        obj.visited_counter = 0;
        obj.transition_counter = containers.Map('KeyType', 'double', 'ValueType', 'any');
    end
    
    function [] = record_visit(self, next_state)          
        
        if ~ isKey(self.transition_counter, next_state)
            self.transition_counter(next_state) = 1;
        else
            self.transition_counter(next_state) = self.transition_counter(next_state) + 1; 
        end
        self.visited_counter = self.visited_counter + 1;
        
    end
    
    function [] = calculate_probabilities(self)
       transition_prob = zeros(1, length(self.transition_counter));
       keySet = keys(self.transition_counter); 
       total_visited = 0;
       for i = 1:length(keySet)
            key = keySet{i};
            total_visited = total_visited + self.transition_counter(key);
            
       end
       
       for i = 1:length(keySet)
          key = keySet{i};
          transition_prob(i) = self.transition_counter(key) / total_visited;           
       end
       self.transition_probabilities = transition_prob;
    end
end
    
end 