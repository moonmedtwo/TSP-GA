clc;
clear;
distance = [ 0      0.730 0.640 0.840 0.800 0.430 0.380 1.010;
             0.730  0     0.710 1.040 0.500 0.300 0.540 0.470;
             0.640  0.710 0     1.420 1.050 0.600 0.920  1.160;
             0.840  1.040 1.420 0     0.740 0.950 0.570  0.900;
             0.800  0.500 1.050 0.740 0     0.520 0.460  0.200
             0.430  0.300 0.600 0.950 0.520 0     0.390  0.690;
             0.380  0.540 0.920 0.570 0.460 0.390 0      0.660;
             1.010  0.470 1.160 0.900 0.200 0.690 0.690  0];
len = length(distance);
popsize = 500;
x = zeros(popsize,1);
p = zeros(popsize,1);
pm = 0.01;

 for i = 1:popsize
     pop(i,:) = randperm(len);
     x(i) = total_dis(pop(i,:));
     fitness(i,1) = 1/x(i);
 end
p = fitness/sum(fitness);
[~,best_factor] = min(x);
best_path = x(best_factor);

crossover_mat = roulette_selection(p);
for tmp = 1:1000
%crossover
for i = 1:(popsize/2)
    parent(i*2-1,:) = pop(crossover_mat(i*2-1),:);
    parent(i*2,:) = pop(crossover_mat(i*2),:);
    offspring(i*2-1,:) = parent(i*2-1,:);
    offspring(i*2,:) = parent(i*2,:);
    cross_point = randi([2 6]);
    for j = 1:cross_point
        m = find(offspring(i*2-1,:)==parent(i*2,j),1);
        if (m > j)
            offspring(i*2-1,m) = offspring(i*2-1,j);
        end
        offspring(i*2-1,j) = parent(i*2,j);
        
        n = find(offspring(i*2,:)==parent(i*2-1,j),1);        
        if (n > j)
            offspring(i*2,n) = offspring(i*2,j);
        end        
        offspring(i*2,j) = parent(i*2-1,j);
    end
end
for i = 1:popsize
    x(i) = total_dis(offspring(i,:));
end
[b,c] = min(x);
if b < best_path
    best_path = b;
    offspring(1,:) = offspring(c,:);
end
end
best_path