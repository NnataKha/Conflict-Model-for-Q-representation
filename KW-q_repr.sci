//conflict for k (capital, money) and w (wealth, goods), not normalized by one
//with another form of growth for total K=sum(k_i) and W=sum(w_i) 
clear;
n = 2; //number of coordinates in vectors
q = [1, 1];
//starting values for  k (capital, money) and w (wealth, goods) at regions
k = [1000, 2000];
w = [200, 150];
//parameters
a = 0.01;
b = 0.05;
alpha = 0.5;

// building the q-representation
s = sum(q);
K_total(1) = sum(k);
W_total(1) = sum(w);
for i=1:n
    delta0(i)=q(i)/s;
    k0(i) = k(i)/K_total(1);
    w0(i) = w(i)/W_total(1);
end
delta = delta0;
d=7; //step of building the destribution
for l=1:d
    i=1;
    for j=1:n^l
        for m=1:n
            delta1(i)=delta(j)*delta0(m);
            k1(i)=k(j)*k0(m);
            w1(i)=w(j)*w0(m);
            i=i+1;
        end
    end
k = k1;
w = w1;
delta = delta1;
end
k = k1*K_total(1);
w = w1*W_total(1);

//conflict

m=10; //number of conflict iterations
lnth=length(k);
T_total(1) = 0;
for j = 1:m
    for i = 1:lnth
        temp_k(i) = k(i)*W_total(j) - w(i);
        temp_w(i) = w(i)*K_total(j) - k(i);
    end
    T_total(j+1) = j;
    W_total(j+1) = a*(W_total(j))^alpha*(K_total(j))^(1-alpha);
    K_total(j+1) = b*(W_total(j+1)-W_total(j))*K_total(j);
    zk = (W_total(j)-1)/(b*(W_total(j+1)-W_total(j)));
    zw = (W_total(j)^(1-alpha)*(K_total(j)+1))/(a*(K_total(j))^(1-alpha));
    for i=1:lnth
        k(i)=temp_k(i)/zk;
        w(i)=temp_w(i)/zw;    
    end
end




//building the graph

build(1) = 0;
build(2) = delta(1);
for i=2:lnth
    build(i+1) = build(i)+delta(i);    
end
T(1) = 0;
k_plot(1) = k(1);
w_plot(1) = w(1);
for i=1:(lnth-1)
    T(i*2)=build(i+1);
    T(i*2+1)=build(i+1);
    k_plot(i*2) = k(i);
    k_plot(i*2+1) = k(i+1);
    w_plot(i*2) = w(i);
    w_plot(i*2+1) = w(i+1);
end
T(lnth*2) = build(lnth+1);
k_plot(lnth*2) = k(lnth);
w_plot(lnth*2) = w(lnth);
subplot(211);
plot(T, k_plot, 'b');
plot(T, w_plot, 'g');
subplot(212);
plot(T_total, K_total, 'b');
plot(T_total, W_total, 'g');
