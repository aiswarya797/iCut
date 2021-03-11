clc;
clear;
R=[
68.3	69.6	73.0	77.8	85.0	92.5	92.2	90.1	88.1
62.3	62.3	66.1	76.0	83.2	89.7	89.7	89.0	87.0
64.9	65.6	70.8	76.4	86.8	92.0	90.6	89.9	86.5

];

P=[
87.3	86.1	84.6	87.0	91.5	95.1	91.2	84.9	77.9
84.7	80.5	79.4	85.4	89.7	92.6	88.2	82.3	74.3
87.4	84.8	84.0	87.6	94.0	96.4	90.3	85.8	75.2
];

F=zeros(size(R,1),size(R,2),'double');

for i=1:size(R,1)
    for j=1:size(R,2)
        F(i,j)=(2*R(i,j)*P(i,j))/(R(i,j)+P(i,j));
    end
end

Y=[0.5 1 1.5 2 2.5 3 3.5 4 4.5];
figure;
plot(Y,F(1,:),'*-r','LineWidth',2,'MarkerSize',10);
xlabel('Parameter:S');
ylabel('F-score:(%)');
hold on
plot(Y,F(2,:),'x-b','LineWidth',2,'MarkerSize',10);hold on
plot(Y,F(3,:),'o-g','LineWidth',2,'MarkerSize',10);hold on