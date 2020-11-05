%% find the most optimal S and s
% M = MonteCarloSearch;
% energy_grid = M.search(); 
% [argvalue, arg] = min(energy_grid(:));
% [S,s] = ind2sub(size(energy_grid),arg);


% Plot histogram
% a = Env;
% S = 12;
% s = 8;
% a.ConstructorDesign(S, s, demand_upper_bound); 
% numdays = 300;
% numtrails = 10000;
% 
% total_costs_history = zeros([1, numdays]); 
% storage_costs_history = zeros([1, numdays]); 
% production_costs_history = zeros([1, numdays]); 
% back_order_costs_history = zeros([1, numdays]);
% avg_costs_history = [total_costs_history, storage_costs_history,...
%     back_order_costs_history, production_costs_history];
% 
% avg_daily_total_cost = zeros([1, numdays]);
% avg_trail = zeros(1, numtrails);
% for j = 1:numtrails
%     
%     for i = 1: numdays
%         [total_costs_history(i), storage_costs_history(i), production_costs_history(i), back_order_costs_history(i)] = a.step(); 
%         avg_daily_total_cost(i) = sum(total_costs_history) / i;
% 
%     end 
%     avg_trail(j) = avg_daily_total_cost(length(avg_daily_total_cost));
% end
% 
% % energy = mean(total_costs_history);
% plot(1:numdays, avg_daily_total_cost);
% title("Average Daily Total Costs when s = 8, S = 12"); 
% hist(avg_trail, 1000);
% title("Average Daily Total Costs Distribution of 10,0000 Monte Carlo Trials")



%% Calculate the transitional probabilities 
% a = Env;
% S = 12;
% s = 8;
% demand_upper_bound = 20;
% a.ConstructorDesign(S, s, demand_upper_bound); 
% numdays = 100000;
% state_dict = containers.Map('KeyType', 'double', 'ValueType','any');
% % state = State;
% 
% for i = 1: numdays
%    curr_inventory = a.get_inventory();
%    display(curr_inventory);
%    if ~ isKey(state_dict, curr_inventory)
%        state_dict(curr_inventory) = State(curr_inventory);
%    end
%    
%    curr_state = state_dict(curr_inventory);
%    
%    a.step();
% 
%    next_inventory = a.get_inventory();
%    curr_state.record_visit(next_inventory); 
%    
% end
% 
% keySet = keys(state_dict);
% for i = 1:length(keySet)
%     
%     key = keySet{i}; 
%     s = state_dict(key);
%     s.calculate_probabilities();
% %     display(s.visited_counter);
%     display(s.transition_probabilities());
%     
% end


%% Estimate Transition Probabilities
% transition_matrix = zeros(20, 20);
% for i = 1:length(keySet)
%     key = keySet{i}; 
%     s = state_dict(key);
%     s.calculate_probabilities();
%     transition_matrix(i, :) = s.transition_probabilities; 
% end




