% Pseudo code

classdef Env < handle
    
    % parameters 
    properties
        s; 
        S; 
        back_order_cost_per_unit = 6;        
        storage_cost_per_unit = 4; 
        production_cost_per_unit = 10;
        fixed_production_cost = 3; 
        
        inventory = 0;
        total_costs = 0;
        total_storage_costs = 0;
        total_production_costs = 0;
        total_back_order_costs = 0;
        
        day_total_costs = 0;
        day_storage_costs = 0;
        day_production_costs = 0;
        day_back_order_costs = 0;
        
        step_counter = 0;
        total_step = 10;
        
        demand_upper_bound;
        
    end

methods
    function [] = ConstructorDesign(self, S, s, demand_upper_bound)
        
        self.s = s; 
        self.S = S; 
        self.demand_upper_bound = demand_upper_bound; 
        
    end
    function [transition_probability] = generate_transitional_probability(self)
        transition_probability = zeros([2 * self.S + 1, 2 * self.S + 1]); 
    end

    % demand probability
    function [d] = sample_demand(self)
        d = randi(self.demand_upper_bound);
    end 

    function [d] = demand_density(self)
        d = 1 / (2*self.S);
    end

    function [day_total_costs, day_storage_costs, day_production_costs, day_back_order_costs] = step(self)
        
        prev_inventory = self.inventory;
        costs = 0;
        
%         Calculate the storage cost   
        storage_cost = prev_inventory * self.storage_cost_per_unit; 
        if prev_inventory <= 0
            storage_cost = 0;
        end
                
    %     Caluclate back order cost
        back_order = 0;
        if (prev_inventory < 0) 
            back_order = prev_inventory * -1 ; 
        end
        back_order_cost = back_order * self.back_order_cost_per_unit;

    %     Calculate how much inventory to produce according to s and S
        production_cost = 0;
        if prev_inventory < self.s 
            production_cost = (self.S - prev_inventory) * self.production_cost_per_unit + self.fixed_production_cost;
            prev_inventory = self.S;
        end 
        
%         Calculate the inventory for the next period
        demand = self.sample_demand(); 
        inventory = prev_inventory - demand;

        costs = storage_cost + back_order_cost + production_cost; 
        self.inventory = inventory;
        self.total_costs = self.total_costs + costs; 
        self.total_storage_costs = self.total_storage_costs + storage_cost;
        self.total_production_costs = self.total_production_costs + production_cost;
        self.total_back_order_costs = self.total_back_order_costs + back_order_cost;
        
        day_total_costs = costs; 
        day_storage_costs = storage_cost;
        day_production_costs = production_cost;
        day_back_order_costs = back_order_cost;
        
        self.step_counter = self.step_counter + 1;
        
%         display(storage_cost);
%         display(back_order_cost);
%         display(storage_cost);
%         display(production_cost);
%         display(self.S - prev_inventory);
%         display(demand);
%         display(prev_inventory);
%         display(inventory);
        
        display_data = [storage_cost, back_order_cost, storage_cost, production_cost, demand, prev_inventory, inventory];
        varnames = {"storage_cost", "back_order_cost", "storage_cost", "production_cost", "demand", "prev_inventory", "inventory"};
%         T = table(display_data(:,1),display_data(:,2),display_data(:,3),display_data(:,4), 'VariableNames',VarNames)
%         display(varnames);
%         display(display_data);
        


    end
    
    function [inventory] = get_inventory(self)
       inventory = self.inventory; 
    end
    
end
    
end 