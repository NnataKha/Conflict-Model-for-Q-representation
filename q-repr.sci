n = 2;
q = [1, 1];
p = [1, 2];
r = [2, 1];
s = sum(q);
sr = sum(r);
sp = sum(p);
for i=1:n
    delta0(i)=q(i)/s;
    p0(i) = p(i)/sp;
    r0(i) = r(i)/sr;
end
delta = delta0;
d=10;
for l=1:d
    i=1;
    for j=1:n^l
        for k=1:n
            delta1(i)=delta(j)*delta0(k);
            p1(i)=p(j)*p0(k);
            r1(i)=r(j)*r0(k);
            i=i+1;
        end
    end
clear p r delta;
p = p1;
r = r1;
delta = delta1;
end

//conflict

k=10;
new_p = p;
new_r = r;
lnth=length(p);
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
build(2) = delta(1);
for i=2:lnth
    build(i+1) = build(i)+delta(i);    
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
