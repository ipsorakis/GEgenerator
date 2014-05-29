function [DATA B] = create_data_stream_given_graph(A,Z,dt_in,dt_out,noise_level)

%Inputs:
%A: NxN adjacency matrix
%Z: length of the data stream
%dt_in: Poisson rate of the average time between observations within  an event 
%dt_out:Poisson rate of the average time between observations between
%events.
%noise_level: \in [0,1] noise level. It defines the probability of
%unconnected individuals appearing within an event.

%Output:
%DATA: Zx3 data stream. 1st column: timestamp | 2nd column: agent ID | 3rd
%column: location ID (fixed to 1 for compatibility)

if ~exist('noise_level','var')
    noise_level = 0;
end

N = size(A,1);
B = [];
cliques = maximalCliques(A,3);

C = length(cliques);

DATA = zeros(Z,3);

t = 1;
z = 0;
while z<Z
    % pick a clique
    clique_index = ceil(rand*C);
    clique = cliques{clique_index};
    bk = zeros(1,N);
    
    % place elements, spread based on dt_in
    clique_size = length(clique);
    for n=1:clique_size
        z = z + 1;
        DATA(z,1) = t;        
        DATA(z,3) = 1;
        
        if rand < noise_level
            added_node = ceil(rand*N);
        else
            added_node = clique(n);
        end
        
        DATA(z,2) = added_node;
        
        bk(1,added_node) = 1;
        
        if n<clique_size
            t = t + ceil(poissrnd(dt_in));
        else
            t = t + ceil(poissrnd(dt_out));
        end
        if t==0
            t=1;
        end
    end
    B = [B;bk];
end


end
