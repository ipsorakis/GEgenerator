The script:

create_gathering_event_data_stream_given_graph.m

creates artificial data streams with gathering event structure, given a fully-observed graph. The gathering events are designed so that closely connected individuals in the observed graph appear in close temporal proximity.

The code is based on Sec. 6.7 chapter 6 of the thesis:
"Probabilistic inference in ecological networks; graph discovery, community detection and modelling dynamic sociality"
by Ioannis Psorakis, University of Oxford

and the upcoming paper:
"Inferring social structure from temporal data"
by Ioannis Psorakis, Bernhard Voelkl, Colin J. Garroway, Reinder Radersma, Lucy M. Aplin, Ross A. Crates, Antica Culina, Damien R Farine, Josh A. Firth, Camilla A. Hinde, Lindal R. Kidd, Nicole Milligan, Stephen R. Roberts, Brecht Verhelst, Ben C. Sheldon

IMPORTANT NOTE - PLEASE READ!!:
========================
Our script create_gathering_event_data_stream_given_graph.m makes use of the following external script:

maximalCliques.m
URL: http://www.mathworks.co.uk/matlabcentral/fileexchange/19889-maximal-cliques

by Ahmad Humyn (ahmad.humyn@gmail.com) of Georgia Tech. Copyright and license of use are provided in the license.txt file in this package.

Inputs:
==========================

A: NxN adjacency matrix

Z: length of the data stream

dt_in: Poisson rate of the average time between observations within  an event 

dt_out:Poisson rate of the average time between observations between events.

 (if dt_in is much smaller than dt_out, we have very modular and "clear" gathering event structure,
 if dt_in = dt_out we have a uniform data stream with no gathering event presence.)

noise_level: \in [0,1] noise level. It defines the probability of unconnected individuals to appear within a

gathering event.

Output:

DATA: Zx3 data stream. 1st column: timestamp | 2nd column: individual ID | 3rd

column: location ID (fixed to 1 for compatibility with gmmevents)

Example:
=======
Say we have created a social network between N individuals, which is described by an adjacency matrix A of size NxN, where A[i,j] = 1 if individuals i and j are connected and 0 otherwise.

We create a data stream of 1000 observations that possesses gathering event structure (see paper “Inferring social network structure in ecological systems from spatio-temporal data streams” 2012), where within each event individuals are ~2 seconds apart, while the time gap between different events is ~60 seconds. 

We may also want to add some noise in the data, so that we may find some coincidental co-occurrences in gathering events among individuals who are not connected in the network implied by A. Say that the probability of such random co-occurrences is 15%.

To generate such a data stream we write:

```
>> create_data_stream_given_graph(A,1000,2,60,0.15)
```
