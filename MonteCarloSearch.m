classdef MonteCarloSearch < handle

    properties
    demand_upper_bound = 20;
    fixed_production_cost = 10;
    numdays = 10000;
    end


methods 
    function energy_grid = search(self)
        
%         initialize s and S 
%         s = self.demand_upper_bound / 2;
%         S = self.demand_upper_bound; 
        
%         numSearchStep = 100; 
        
        energy_grid = zeros([self.demand_upper_bound, self.demand_upper_bound]);
        
        for S=1:self.demand_upper_bound
           for s=1:S
             display([S,s]);
             energy_grid(S, s) = self.evaluate(S, s);
           end
        end
        
        
    end 
        
        
    function energy = evaluate(self, S, s) 
 
        a = Env;
        a.ConstructorDesign(S, s, self.demand_upper_bound); 

        total_costs_history = zeros([1, self.numdays]); 
        storage_costs_history = zeros([1, self.numdays]); 
        production_costs_history = zeros([1, self.numdays]); 
        back_order_costs_history = zeros([1, self.numdays]);
        avg_costs_history = [total_costs_history, storage_costs_history,...
            back_order_costs_history, production_costs_history];

        for i = 1: self.numdays

            [total_costs_history(i), storage_costs_history(i), production_costs_history(i), back_order_costs_history(i)] = a.step(); 

        end 

        energy = mean(total_costs_history);

    end 

end 
end

% plot(1:numdays, storage_costs_history);
% hist(storage_costs_history, 100);

