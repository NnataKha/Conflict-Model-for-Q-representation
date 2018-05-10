clear;
n = 3;
q = [1, 1, 1];//, 1, 1];
p = [1, 2, 3];//, 1, 1];
r = [1, 10, 1];//, 1, 1];
s = sum(q);
sr = sum(r);
sp = sum(p);
for i=1:n
    delta1(i)=q(i)/s;
    p1(i) = p(i)/sp;
    r1(i) = r(i)/sr;
end
i=1;
for j=1:n
    for k=1:n
        delta2(i)=delta1(j)*q(k)/s;
        p2(i)=p1(j)*p(k)/sp;
        r2(i)=r1(j)*r(k)/sr;
        i=i+1;
    end
end
i=1;
for j=1:n^2
    for k=1:n
        delta3(i)=delta2(j)*q(k)/s;
        p3(i)=p2(j)*p(k)/sp;
        r3(i)=r2(j)*r(k)/sr;
        i=i+1;
    end
end
i=1;
for j=1:n^3
    for k=1:n
        delta4(i)=delta3(j)*q(k)/s;
        p4(i)=p3(j)*p(k)/sp;
        r4(i)=r3(j)*r(k)/sr;
        i=i+1;
    end
end
i=1;
for j=1:n^4
    for k=1:n
        delta5(i)=delta4(j)*q(k)/s;
        p5(i)=p4(j)*p(k)/sp;
        r5(i)=r4(j)*r(k)/sr;
        i=i+1;
    end
end
i=1;
for j=1:n^5
    for k=1:n
        delta6(i)=delta5(j)*q(k)/s;
        p6(i)=p5(j)*p(k)/sp;
        r6(i)=r5(j)*r(k)/sr;
        i=i+1;
    end
end
i=1;
for j=1:n^6
    for k=1:n
        delta7(i)=delta6(j)*q(k)/s;
        p7(i)=p6(j)*p(k)/sp;
        r7(i)=r6(j)*r(k)/sr;
        i=i+1;
    end
end
// create probability vectors
k=1000;
lnth=length(p7);
for i=1:lnth
    new_p(i)=p7(i);
    new_r(i)=r7(i);
end
//conflict iterations
for j = 1:k
    K_pl(j)=j;
    for i = 1:lnth
     temp_p(i) = new_p(i)*(1-new_r(i));
     temp_r(i) = new_r(i)*(1-new_p(i));
    end
    z1=sum(temp_p);
    z2=sum(temp_r);
    for i=1:lnth
        new_p(i)=temp_p(i)/z1;
        new_r(i)=temp_r(i)/z2;    
    end
end
//building the graph
build(1) = 0;
build(2) = delta7(1);
for i=2:lnth
    build(i+1) = build(i)+delta7(i);    
end
T(1) = 0;
p_plot(1) = new_p(1);
r_plot(1) = new_r(1);
for i=1:(lnth-1)
    T(i*2)=build(i+1);
    T(i*2+1)=build(i+1);
    p_plot(i*2) = new_p(i);
    p_plot(i*2+1) = new_p(i+1);
    r_plot(i*2) = new_r(i);
    r_plot(i*2+1) = new_r(i+1);
end
T(lnth*2) = build(lnth+1);
p_plot(lnth*2) = new_p(lnth);
r_plot(lnth*2) = new_r(lnth);
subplot(311);
plot(T, p_plot, 'b');
subplot(312);
plot(T, r_plot, 'g');
subplot(313);
plot(T, r_plot, 'g');
plot(T, p_plot, 'b');



