clc;clear
% ����f(x,y) = (1 - x)^2 + 100 * (y-x*x)^2 ����Сֵʱx,y��ȡֵ

fxy = @(x,y) ((1 - x)^2 + 100 * (y-x*x)^2)
Jf = @(x,y) ([2*(x-1)-400*x*(y-x*x),200*(y-x*x)])

x = 5; y = 5; % ��ʼ��x��y
iter = 100000; % ��������
error1 = 1e-6 ;  % x�������
error2 = 1e-6 ;  % y�������
u = 1 ;  % ��ʼlamda

record_x = [x];     % x�ĵ�����¼
record_y = [y];     % y�ĵ�����¼
record_lamda = [u]; % lamda�ĵ�����¼
record_grad = [0;0];  % �����ĵ�����¼

for i = 1:iter
    H = Jf(x,y)' .* Jf(x,y);  % Hessian ����
    G = H + u*eye(size(H));  % LM�㷨����Hessian���� ,����IΪdiag(1,1...)
    last_x = x; last_y = y;   % ��¼�ϱ��ε�����x,yֵ
    
    while det(G) == 0  % ������Hessian���������
        u = u*4;      % ����uֵ��ֱ������Hessian��������
    end
    G = H + u*eye(size(H));   %����Hessian����
    r = (G)^(-1)* Jf(x,y)'* fxy(x,y);   % ��������������
    A = [x;y] - r ; % ���� x��y��ֵ
    x = A(1);  % x��ֵ
    y = A(2);  % y��ֵ
    
    record_x(i+1) = x;
    record_x(i+1) = y;
    record_grad(:,i) = r;
    
    if 0 < r < 0.25   % �����������̫С��ʱ������һ��������ʱ���ʵ��Ӵ��������
        u = u * 4;
        
    elseif 0.25 <= r <= 0.75 % �������������ʣ����ֲ���
        u = u;
    
    elseif r > 0.75 % �����������̫���ʱ������һ��������ʱ���ʵ���С�������룬����Խ�����ŵ�
        u = u / 2;
 
    end
    
    record_lamda(i+1) = u ;
    
    if r < 0    %��rk��0 ��˵������ֵ���������������½������Ʊ仯�ˣ������Ż���Ŀ���෴������ֹͣ����
        break
    end
    
     if abs(last_x - x) < error1 && abs(last_y - y) < error2  % ���������ﵽ�趨ֵ��ֹͣ����
        break
    end
    
end
    
    
    
    